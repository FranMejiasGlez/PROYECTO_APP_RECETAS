// controllers/recetasController.js
const recetaService = require('../services/recetasServices'); // Asegúrate que la ruta sea correcta

exports.obtenerTodos = async (req, res) => {
  try {
    const recetas = await recetaService.obtenerTodasLasRecetas();
    res.status(200).json(recetas);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.obtenerPorId = async (req, res) => {
  try {
    const receta = await recetaService.obtenerRecetaPorId(req.params.id);
    if (!receta) {
      return res.status(404).json({ msg: 'Receta no encontrada' });
    }
    res.status(200).json(receta);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.crear = async (req, res) => {
  try {
    // Aquí confiamos en que el Validator ya filtró los datos malos.
    // Simplemente llamamos al servicio.
    const nuevaReceta = await recetaService.crearReceta(req.body);
    res.status(201).json(nuevaReceta);

  } catch (error) {
    // Este catch solo saltará si:
    // 1. Se cae la base de datos.
    // 2. El Validator dejó pasar algo que Mongoose rechazó (nuestra "segunda barrera").
    console.error(error); 
    res.status(400).json({ msg: 'Error al procesar la receta', error: error.message });
  }
};

exports.actualizar = async (req, res) => {
  try {
    const recetaActualizada = await recetaService.actualizarReceta(req.params.id, req.body);
    if (!recetaActualizada) {
      return res.status(404).json({ msg: 'Receta no encontrada' });
    }
    res.status(200).json(recetaActualizada);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

exports.eliminar = async (req, res) => {
  try {
    const recetaEliminada = await recetaService.eliminarReceta(req.params.id);
    if (!recetaEliminada) {
      return res.status(404).json({ msg: 'Receta no encontrada' });
    }
    res.status(200).json({ msg: 'Receta eliminada correctamente' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};