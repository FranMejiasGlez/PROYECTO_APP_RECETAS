const Usuario = require('../models/usuarioModelo');
const fs = require('fs');
const path = require('path');
const sharp = require('sharp');
const bcrypt = require('bcryptjs'); // ✅ Importar bcryptjs

// Función auxiliar para generar username aleatorio
const generarUsername = () => {
  return `user_${Math.floor(10000 + Math.random() * 90000)}`;
};

// Crear usuario (Registro)
exports.registrarUsuario = async (datos) => {
  // 1. Verificamos si el email ya existe
  const existeEmail = await Usuario.findOne({ email: datos.email });
  if (existeEmail) {
    throw new Error('El correo electrónico ya está registrado');
  }

  // 2. Gestionamos el username
  let username = datos.username;

  if (username) {
    // Si nos pasan un username, verificamos que no exista
    const existeUser = await Usuario.findOne({ username });
    if (existeUser) {
      throw new Error('El nombre de usuario ya está en uso');
    }
  } else {
    // Si no viene, generamos uno aleatorio
    username = generarUsername();
    let existeUser = await Usuario.findOne({ username });
    while (existeUser) {
      username = generarUsername();
      existeUser = await Usuario.findOne({ username });
    }
  }

  // 3. Hashear contraseña
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash(datos.password, salt);

  // 4. Creamos el usuario
  const nuevoUsuario = new Usuario({
    ...datos,
    username: username,
    password: hashedPassword, // ✅ Guardamos hash
    recetas_guardadas: []
  });

  return await nuevoUsuario.save();
};

// Obtener usuario por ID
exports.obtenerUsuarioPorId = async (id) => {
  return await Usuario.findById(id)
    .populate('recetas_guardadas')
    .populate('siguiendo', 'username profile_image')
    .populate('seguidores', 'username profile_image');
};

// Obtener usuario por Username
exports.buscarUsuarioPorUsername = async (username) => {
  return await Usuario.findOne({ username: username })
    .select('_id username profile_image bio');
};

// Login (Email o Username)
exports.loginUsuario = async (identifier, password) => {
  // 1. Buscamos usuario
  const usuario = await Usuario.findOne({
    $or: [{ email: identifier }, { username: identifier }]
  });

  if (!usuario) return null;

  // 2. Verificar contraseña (BCRYPT)
  const isMatch = await bcrypt.compare(password, usuario.password);

  if (isMatch) {
    return usuario;
  }

  // 3. FALLBACK: Verificar texto plano (Legacy Migración)
  // Si bcrypt falla, puede ser porque es un usuario viejo con pass en texto plano
  if (usuario.password === password) {
    console.log(`⚠️ Migrando usuario ${usuario.username} a bcrypt...`);

    // Si coincide en texto plano, la hasheamos y guardamos
    const salt = await bcrypt.genSalt(10);
    usuario.password = await bcrypt.hash(password, salt);
    await usuario.save();

    return usuario;
  }

  return null;
};

// Actualizar perfil
exports.actualizarUsuario = async (id, datos, archivo) => {
  // -> PROCESAR CONTRASEÑA NUEVA
  if (datos.password) {
    const salt = await bcrypt.genSalt(10);
    datos.password = await bcrypt.hash(datos.password, salt);
  }

  // -> PROCESAR IMAGEN NUEVA
  if (archivo) {
    // 1. Verificar si tenía foto anterior para borrarla
    const usuarioActual = await Usuario.findById(id);
    if (usuarioActual && usuarioActual.profile_image) {
      if (usuarioActual.profile_image.startsWith('img/')) {
        const rutaAbsoluta = path.join(__dirname, '../', usuarioActual.profile_image);
        fs.unlink(rutaAbsoluta, (err) => {
          if (err && err.code !== 'ENOENT') console.error("Error borrando foto perfil antigua:", err);
        });
      }
    }

    // 2. Procesar (Sharp) y Guardar nueva
    const nombreArchivo = `user_${id}_${Date.now()}.jpeg`;
    const rutaArchivo = path.join('img', nombreArchivo);

    try {
      await sharp(archivo.buffer)
        .resize(400, 400, { fit: 'cover' })
        .toFormat('jpeg')
        .jpeg({ quality: 80 })
        .toFile(rutaArchivo);

      datos.profile_image = rutaArchivo.replace(/\\/g, '/');
    } catch (error) {
      console.error("Error procesando imagen perfil:", error);
      throw new Error("Error al procesar la imagen de perfil");
    }
  }

  return await Usuario.findByIdAndUpdate(id, datos, { new: true, runValidators: true });
};

// Guardar/Quitar Receta (Toggle)
exports.toggleRecetaGuardada = async (idUsuario, idReceta) => {
  const usuario = await Usuario.findById(idUsuario);
  if (!usuario) throw new Error('Usuario no encontrado');

  const index = usuario.recetas_guardadas.indexOf(idReceta);

  if (index === -1) {
    // No la tiene guardada -> La añadimos
    usuario.recetas_guardadas.push(idReceta);
  } else {
    // Ya la tiene -> La quitamos
    usuario.recetas_guardadas.splice(index, 1);
  }

  return await usuario.save();
};

exports.toggleSeguimiento = async (idUsuarioOrigen, idUsuarioDestino) => {
  // 1. Evitar que se siga a sí mismo
  if (idUsuarioOrigen === idUsuarioDestino) {
    throw new Error('No puedes seguirte a ti mismo');
  }

  // 2. Buscar ambos usuarios
  const usuarioOrigen = await Usuario.findById(idUsuarioOrigen);
  const usuarioDestino = await Usuario.findById(idUsuarioDestino);

  if (!usuarioOrigen || !usuarioDestino) {
    throw new Error('Uno de los usuarios no existe');
  }

  // 3. Comprobar si YA lo está siguiendo
  const estaSiguiendo = usuarioOrigen.siguiendo.includes(idUsuarioDestino);

  if (estaSiguiendo) {
    // --- UNFOLLOW (Dejar de seguir) ---

    // Quitar de mis "siguiendo"
    usuarioOrigen.siguiendo.pull(idUsuarioDestino);
    // Quitar de sus "seguidores"
    usuarioDestino.seguidores.pull(idUsuarioOrigen);

  } else {
    // --- FOLLOW (Seguir) ---

    // Añadir a mis "siguiendo"
    usuarioOrigen.siguiendo.push(idUsuarioDestino);
    // Añadir a sus "seguidores"
    usuarioDestino.seguidores.push(idUsuarioOrigen);
  }

  // 4. Guardar ambos cambios
  // Usamos Promise.all para que se guarden en paralelo (más rápido)
  await Promise.all([usuarioOrigen.save(), usuarioDestino.save()]);

  // Retornamos el estado actual para que el frontend sepa si ahora lo sigue o no
  return {
    siguiendo: !estaSiguiendo, // true si ahora lo sigue, false si dejó de seguir
    totalSeguidoresDestino: usuarioDestino.seguidores.length,
    totalSiguiendoOrigen: usuarioOrigen.siguiendo.length
  };
};