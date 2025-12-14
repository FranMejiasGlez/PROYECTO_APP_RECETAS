const mongoose = require('mongoose');

const categoriaSchema = new mongoose.Schema({
  nombre: {
    type: String,
    required: true,
    unique: true, // No queremos duplicados
    trim: true,
    lowercase: true // Guardaremos siempre en minúsculas: "mexicana"
  }
}, {
  versionKey: false
});

module.exports = mongoose.model('Categoria', categoriaSchema, 'categorias');