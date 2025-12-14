const Usuario = require('../models/usuarioModelo');

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

  // 2. Generamos username aleatorio si no viene (aunque por tu regla, siempre se genera)
  let username = generarUsername();
  
  // Pequeña validación por si el random choca con uno existente (raro pero posible)
  let existeUser = await Usuario.findOne({ username });
  while (existeUser) {
    username = generarUsername();
    existeUser = await Usuario.findOne({ username });
  }

  // 3. Creamos el usuario
  const nuevoUsuario = new Usuario({
    ...datos,
    username: username,
    recetas_guardadas: [] // Inicializamos vacío
  });

  return await nuevoUsuario.save();
};

// Obtener usuario por ID
exports.obtenerUsuarioPorId = async (id) => {
  return await Usuario.findById(id)
    .populate('recetas_guardadas') // Trae las recetas completas
    .populate('siguiendo', 'username profile_image') // Trae solo nombre y foto de a quien sigo
    .populate('seguidores', 'username profile_image'); // Trae solo nombre y foto de mis seguidores
};

// Login simple (Buscar por email y password)
// NOTA: En un entorno real, aquí compararíamos hashes (bcrypt), no texto plano.
exports.loginUsuario = async (email, password) => {
  const usuario = await Usuario.findOne({ email, password });
  return usuario;
};

// Actualizar perfil (Bio, Username, Email, Foto)
exports.actualizarUsuario = async (id, datos) => {
  // Si intenta cambiar username o email, habría que validar que no existan ya
  // Por simplicidad, asumimos que el frontend o mongo (unique constraint) manejará el error de duplicado
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