// services/recetaService.js
const Receta = require('../models/recetaModelo');

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
exports.crearReceta = async (recetaData) => {
  const nuevaReceta = new Receta(recetaData);
  return await nuevaReceta.save();
};

// Actualizar receta
exports.actualizarReceta = async (id, datosActualizados) => {
  return await Receta.findByIdAndUpdate(id, datosActualizados, {
    new: true, // Devolver el objeto actualizado
    runValidators: true // Ejecutar validaciones del Schema
  });
};

// Eliminar receta
exports.eliminarReceta = async (id) => {
  return await Receta.findByIdAndDelete(id);
};