const Comentario = require('../models/comentarioModelo');

// Crear un comentario
exports.crearComentario = async (datos) => {
  const comentario = new Comentario(datos);
  return await comentario.save();
};

// Obtener comentarios de una Receta específica (Ordenados por más recientes)
exports.obtenerPorReceta = async (recetaId) => {
  return await Comentario.find({ receta: recetaId })
    .sort({ createdAt: -1 }); // -1 significa descendente (nuevos primero)
};

// Editar comentario
exports.editarComentario = async (id, nuevoContenido) => {
  return await Comentario.findByIdAndUpdate(
    id, 
    { contenido: nuevoContenido }, 
    { new: true, runValidators: true }
  );
};

// Eliminar comentario
exports.eliminarComentario = async (id) => {
  return await Comentario.findByIdAndDelete(id);
};