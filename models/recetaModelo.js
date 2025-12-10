const mongoose = require('mongoose');

const recetaSchema = new mongoose.Schema({
  // El _id lo genera Mongo automáticamente, no es necesario definirlo aquí

  // 'user' es el ID del usuario creador
  user: {
    type: String,
    required: true
  },

  nombre: {
    type: String,
    required: [true, 'El nombre de la receta es obligatorio'],
    trim: true // Elimina espacios en blanco al inicio y final
  },

  comensales: {
    type: Number,
    required: true,
    min: 1 // Validar que al menos sea para 1 persona
  },

  dificultad: {
    type: Number, // Lo definimos como Number para poder usar rangos
    required: true,
    min: [1, 'La dificultad mínima es 1'],
    max: [5, 'La dificultad máxima es 5']
  },

  categoria: {
    type: String,
    required: true,
    trim: true,
    lowercase: true // Guarda "Mexicana" como "mexicana" para facilitar búsquedas
  },

  tiempo: {
    type: String, // "1 1/2 horas" requiere ser String
    required: true
  },

  ingredientes: {
    type: [String], // Array de cadenas de texto
    required: true,
    validate: {
      // Validación personalizada: el array no puede estar vacío
      validator: function(v) {
        return v && v.length > 0;
      },
      message: 'La receta debe tener al menos un ingrediente'
    }
  },

  instrucciones: {
    type: [String],
    required: true
  },
}, {
  timestamps: true, // Añade automáticamente createdAt y updatedAt
  versionKey: false // Elimina el campo __v que añade Mongo por defecto
});

module.exports = mongoose.model('Receta', recetaSchema);