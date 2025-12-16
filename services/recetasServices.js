// services/recetaService.js
const Receta = require('../models/recetaModelo');
const Comentario = require('../models/comentarioModelo');
const fs = require('fs');
const path = require('path');
const sharp = require('sharp');

// Función auxiliar para renombrar imágenes
const procesarImagenes = async (archivos, recetaId, indiceInicial) => {
  if (!archivos || archivos.length === 0) return [];

  let rutasGuardadas = [];

  for (let i = 0; i < archivos.length; i++) {
    const file = archivos[i];

    // Nombre del archivo
    const nuevoNombre = `${recetaId}_${indiceInicial + i + 1}.jpeg`;
    const rutaArchivo = path.join('img', nuevoNombre);

    try {
      // OPTIMIZACIÓN AVANZADA
      await sharp(file.buffer)
        .resize({
          width: 800,             // Objetivo: 800px
          withoutEnlargement: true // IMPORTANTE: Si es más pequeña, NO la estires
        })
        .toFormat('jpeg')
        .jpeg({
          quality: 70,     // Bajamos un poco la calidad (casi imperceptible)
          mozjpeg: true    // Algoritmo de compresión avanzado para ahorrar espacio
        })
        .toFile(rutaArchivo);

      rutasGuardadas.push(rutaArchivo.replace(/\\/g, '/'));

    } catch (error) {
      console.error("Error procesando imagen:", error);
    }
  }

  return rutasGuardadas;
};

// Obtener todas
exports.obtenerTodasLasRecetas = async () => {
  // Aquí podrías agregar lógica extra, filtros, etc.
  return await Receta.find();
};

// Obtener por ID
exports.obtenerRecetaPorId = async (id) => {
  return await Receta.findById(id);
};

// Crear receta
exports.crearReceta = async (datos, archivos) => {
  const nuevaReceta = new Receta(datos);
  const id = nuevaReceta._id;

  // AWAIT AQUÍ ES IMPORTANTE AHORA
  const imagenesProcesadas = await procesarImagenes(archivos, id, 0);

  nuevaReceta.imagenes = imagenesProcesadas;
  return await nuevaReceta.save();
};

// Actualizar receta
exports.actualizarReceta = async (id, datos, archivos) => {
  const receta = await Receta.findById(id);
  if (!receta) return null;

  // 0. PROCESAR imagenesPrevias (calcular qué imágenes eliminar automáticamente)
  if (datos.imagenesPrevias !== undefined && Array.isArray(datos.imagenesPrevias)) {
    const imagenesOriginales = receta.imagenes || [];

    if (datos.imagenesPrevias.length === 0) {
      // Si imagenesPrevias está vacío → eliminar TODAS las imágenes existentes
      datos.imagenesAEliminar = [...imagenesOriginales];
      console.log('imagenesPrevias vacío: eliminando todas las imágenes');
    } else {
      // imagenesPrevias tiene elementos → calcular cuáles fueron eliminadas
      const imagenesQueQuedan = datos.imagenesPrevias;
      datos.imagenesAEliminar = imagenesOriginales.filter(img => !imagenesQueQuedan.includes(img));
      console.log('imagenesPrevias con elementos: eliminando', datos.imagenesAEliminar);
    }
    // Limpiar este campo para que no se guarde en la BD
    delete datos.imagenesPrevias;
  }

  // 1. ELIMINAR IMÁGENES (si vienen en el body)
  if (datos.imagenesAEliminar && Array.isArray(datos.imagenesAEliminar)) {
    for (const rutaRelativa of datos.imagenesAEliminar) {
      // Verificar que la imagen pertenece a esta receta (seguridad)
      if (receta.imagenes.includes(rutaRelativa)) {
        // Borrar archivo físico del servidor
        const rutaAbsoluta = path.join(__dirname, '../', rutaRelativa);
        try {
          await fs.promises.unlink(rutaAbsoluta);
          console.log(`Imagen eliminada: ${rutaRelativa}`);
        } catch (err) {
          if (err.code !== 'ENOENT') {
            console.error("Error borrando imagen:", err);
          }
        }
        // Quitar del array de la receta
        receta.imagenes = receta.imagenes.filter(img => img !== rutaRelativa);
      }
    }
    // Eliminar este campo para que no se guarde en la BD
    delete datos.imagenesAEliminar;
  }

  // 2. ACTUALIZAR DATOS de la receta
  Object.assign(receta, datos);

  // 3. AÑADIR NUEVAS IMÁGENES (si vienen archivos)
  if (archivos && archivos.length > 0) {
    const totalExistentes = receta.imagenes.length;
    const nuevasRutas = await procesarImagenes(archivos, id, totalExistentes);
    receta.imagenes.push(...nuevasRutas);
  }

  return await receta.save();
};

exports.eliminarReceta = async (id) => {
  // 1. Buscamos la receta ANTES de borrarla para saber qué imágenes tiene
  const receta = await Receta.findById(id);

  if (!receta) return null;

  // 2. Borrado de IMÁGENES (Limpieza del Servidor)
  if (receta.imagenes && receta.imagenes.length > 0) {
    receta.imagenes.forEach(rutaRelativa => {
      // rutaRelativa viene como "img/ID_1.jpeg"
      // Resolvemos la ruta absoluta para evitar errores
      const rutaAbsoluta = path.join(__dirname, '../', rutaRelativa);

      // Usamos unlink para borrar el archivo
      fs.unlink(rutaAbsoluta, (err) => {
        if (err) {
          // Si el archivo no existe (ej: ya lo borraste manual), no pasa nada, solo logueamos
          if (err.code !== 'ENOENT') console.error("Error borrando imagen:", err);
        } else {
          console.log(`Imagen eliminada: ${rutaRelativa}`);
        }
      });
    });
  }

  // 3. Borrado de COMENTARIOS (Limpieza de la DB - Cascada)
  await Comentario.deleteMany({ receta: id });

  // 4. Finalmente, borramos la RECETA de la DB
  return await Receta.findByIdAndDelete(id);
};

// Valorar receta
exports.valorarReceta = async (id, idUsuario, puntuacion) => {
  // 1. Buscamos la receta
  const receta = await Receta.findById(id);
  if (!receta) return null;

  // 2. Buscamos si este usuario ya había votado antes
  const indiceVoto = receta.valoraciones.findIndex(v => v.usuario === idUsuario);

  if (indiceVoto !== -1) {
    // YA VOTÓ: Actualizamos su puntuación existente
    receta.valoraciones[indiceVoto].puntuacion = puntuacion;
  } else {
    // NO VOTÓ: Añadimos un voto nuevo al array
    receta.valoraciones.push({ usuario: idUsuario, puntuacion });
  }

  // 3. Guardamos (Esto dispara el 'pre save' del modelo automáticamente)
  return await receta.save();
};