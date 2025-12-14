const mongoose = require('mongoose');

const usuarioSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
    trim: true
  },
  email: {
    type: String,
    required: [true, 'El email es obligatorio'],
    unique: true,
    trim: true,
    lowercase: true,
    match: [/.+\@.+\..+/, 'Por favor ingrese un email válido'] // Validación simple de regex
  },
  password: {
    type: String,
    required: [true, 'La contraseña es obligatoria']
  },
  profile_image: {
    type: String, // Ruta a la imagen (ej: "img/users/foto.jpg")
    default: ''
  },
  bio: {
    type: String,
    default: '',
    maxlength: [200, 'La biografía no puede exceder los 200 caracteres']
  },
  recetas_guardadas: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Receta' // Referencia al modelo de Recetas
  }],
  siguiendo: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Usuario' // Referencia a otros usuarios
  }],
  
  seguidores: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Usuario'
  }]
}, {
  timestamps: true,
  versionKey: false
});

module.exports = mongoose.model('Usuario', usuarioSchema, 'usuarios');