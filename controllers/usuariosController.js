const usuarioService = require('../services/usuariosServices');

// Registro
exports.registrar = async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ msg: 'Email y contraseña son obligatorios' });
    }

    const nuevoUsuario = await usuarioService.registrarUsuario(req.body);
    res.status(201).json(nuevoUsuario);
  } catch (error) {
    // Manejo de error de duplicados de Mongo (E11000)
    if (error.message.includes('El correo electrónico ya está registrado') || error.code === 11000) {
        return res.status(400).json({ msg: 'El correo ya existe' });
    }
    res.status(500).json({ error: error.message });
  }
};

// Login (Simple)
const jwt = require('jsonwebtoken'); // <--- Añade esto arriba del archivo
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;
    const usuario = await usuarioService.loginUsuario(email, password);
    
    if (!usuario) {
      return res.status(401).json({ msg: 'Credenciales inválidas' });
    }

    // --- GENERACIÓN DEL TOKEN (Nueva lógica) ---
    const token = jwt.sign(
      { 
        id_user: usuario._id, 
        nombreUser: usuario.username, // Usamos username que genera tu service
        email: usuario.email 
      },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );

    // Devolvemos el usuario Y el token inicial
    res.status(200).json({
      token: token,
      usuario: usuario
    });

  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Obtener Perfil
exports.perfil = async (req, res) => {
  try {
    const usuario = await usuarioService.obtenerUsuarioPorId(req.params.id);
    if (!usuario) return res.status(404).json({ msg: 'Usuario no encontrado' });
    res.status(200).json(usuario);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Actualizar Datos (Bio, Username, Password, Email)
exports.actualizar = async (req, res) => {
  try {
    // Evitar que actualicen recetas_guardadas por esta ruta
    delete req.body.recetas_guardadas; 
    
    const usuario = await usuarioService.actualizarUsuario(req.params.id, req.body);
    if (!usuario) return res.status(404).json({ msg: 'Usuario no encontrado' });
    
    res.status(200).json(usuario);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Guardar/Quitar Receta
exports.guardarReceta = async (req, res) => {
  try {
    const { id } = req.params; // ID del Usuario
    const { recetaId } = req.body; // ID de la Receta a guardar

    if (!recetaId) return res.status(400).json({ msg: 'Falta el ID de la receta' });

    const usuario = await usuarioService.toggleRecetaGuardada(id, recetaId);
    res.status(200).json({ 
      msg: 'Lista de guardados actualizada', 
      guardadas: usuario.recetas_guardadas 
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.seguirUsuario = async (req, res) => {
  try {
    const { id } = req.params; // El usuario que hace la acción (Andy)
    const { idDestino } = req.body; // El usuario al que queremos seguir (Pepe)

    if (!idDestino) {
      return res.status(400).json({ msg: 'Falta el ID del usuario a seguir' });
    }

    const resultado = await usuarioService.toggleSeguimiento(id, idDestino);

    res.status(200).json({
      msg: resultado.siguiendo ? 'Ahora sigues a este usuario' : 'Has dejado de seguir a este usuario',
      datos: resultado
    });

  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

exports.obtenerTodos = async (req, res) => {
  try {
    // Buscamos todos los usuarios pero solo devolvemos campos publicos
    const usuarios = await require('../models/usuarioModelo').find().select('-password');
    res.status(200).json(usuarios);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};