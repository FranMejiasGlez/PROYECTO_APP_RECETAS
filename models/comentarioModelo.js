const mongoose = require('mongoose');

const comentarioSchema = new mongoose.Schema({
  usuario: {
    type: String, // "andy" por ahora
    required: true
  },
  receta: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Receta', // Referencia al modelo Receta
    required: true
  },
  contenido: {
    type: String,
    required: [true, 'El comentario no puede estar vacío'],
    trim: true,
    maxlength: [500, 'El comentario no puede exceder los 500 caracteres']
  }
}, {
  timestamps: true, // Esto genera createdAt (fecha creación) y updatedAt
  versionKey: false
});

// OPTIMIZACIÓN: Índice para buscar rápido comentarios de una receta ordenados por fecha
comentarioSchema.index({ receta: 1, createdAt: -1 });

module.exports = mongoose.model('Comentario', comentarioSchema);