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

    Object.assign(receta, datos);

    if (archivos && archivos.length > 0) {
        const totalExistentes = receta.imagenes.length;
        // AWAIT AQUÍ TAMBIÉN
        const nuevasRutas = await procesarImagenes(archivos, id, totalExistentes);
        receta.imagenes.push(...nuevasRutas);
    }

    return await receta.save();
};

// Eliminar receta
exports.eliminarReceta = async (id) => {
  // 1. Primero borramos todos los comentarios asociados a esa receta
  await Comentario.deleteMany({ receta: id });

  // 2. Ahora que está limpia, borramos la receta
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