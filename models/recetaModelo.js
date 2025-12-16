const mongoose = require('mongoose');

const recetaSchema = new mongoose.Schema({
  // --- TUS CAMPOS DE SIEMPRE ---
  nombre: {
    type: String,
    required: [true, 'El nombre de la receta es obligatorio'],
    trim: true
  },
  descripcion: {
    type: String,
    required: false,
    trim: true,
    maxLength: 500
  },
  comensales: {
    type: Number,
    required: true,
    min: 1
  },
  dificultad: {
    type: Number,
    required: true,
    min: 1,
    max: 5
  },
  categoria: {
    type: String,
    required: true,
    trim: true,
    lowercase: true
  },
  tiempo: {
    type: String,
    required: true
  },
  ingredientes: {
    type: [String],
    required: true,
    validate: {
      validator: function (v) { return v && v.length > 0; },
      message: 'La receta debe tener al menos un ingrediente'
    }
  },
  instrucciones: {
    type: [String],
    required: true
  },
  user: {
    type: String,
    required: true
  },

  // --- NUEVOS CAMPOS PARA VALORACIONES ---
  valoraciones: [
    {
      usuario: { type: String, required: true },
      puntuacion: { type: Number, required: true, min: 1, max: 5 }
    }
  ],
  promedio: {
    type: Number,
    default: 0
  },
  cantidadVotos: {
    type: Number,
    default: 0
  },

  youtube: {
    type: String,
    required: false, // Opcional
    trim: true
  },
  imagenes: {
    type: [String], // Guardaremos ["img/ID_1.jpg", "img/ID_2.jpg"]
    default: []
  },

}, {
  timestamps: true,
  versionKey: false
});

// --- EL CÁLCULO AUTOMÁTICO ---
recetaSchema.pre('save', async function () {
  // 1. Solo calculamos si las valoraciones han cambiado
  if (!this.isModified('valoraciones')) return;

  const total = this.valoraciones.length;
  this.cantidadVotos = total;

  // 2. Cálculo matemático
  if (total > 0) {
    const suma = this.valoraciones.reduce((acc, val) => acc + val.puntuacion, 0);
    // 3. Guardamos con 1 decimal
    this.promedio = parseFloat((suma / total).toFixed(1));
  } else {
    this.promedio = 0;
  }

  // NO llamamos a next(). Al ser async, Mongoose sabe que cuando acaba la función, puede continuar.
});
// Forzamos que la colección se llame 'recetas'


module.exports = mongoose.model('Receta', recetaSchema, 'recetas');