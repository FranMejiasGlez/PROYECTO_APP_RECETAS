const recetaService = require('../services/recetasServices');

// ==========================================
// GET - OBTENER TODAS
// ==========================================
exports.obtenerTodos = async (req, res) => {
  try {
    const recetas = await recetaService.obtenerTodasLasRecetas();
    res.status(200).json(recetas);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// ==========================================
// GET - OBTENER POR ID
// ==========================================
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

// ==========================================
// POST - CREAR RECETA
// ==========================================
exports.crear = async (req, res) => {
  try {
    const nuevaReceta = await recetaService.crearReceta(req.body, req.files);
    res.status(201).json(nuevaReceta);
  } catch (error) {
    console.error(error);
    res.status(400).json({ msg: 'Error al procesar la receta', error: error.message });
  }
};

// ==========================================
// PUT - ACTUALIZAR
// ==========================================
exports.actualizar = async (req, res) => {
  try {
    const recetaActualizada = await recetaService.actualizarReceta(req.params.id, req.body, req.files);
    if (!recetaActualizada) {
      return res.status(404).json({ msg: 'Receta no encontrada' });
    }
    res.status(200).json(recetaActualizada);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// ==========================================
// DELETE - ELIMINAR
// ==========================================
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

// ==========================================
// POST - VALORAR RECETA (Estrellas)
// ==========================================
exports.valorar = async (req, res) => {
  try {
    const { id } = req.params;
    const { puntuacion, user } = req.body;

    if (!puntuacion || puntuacion < 1 || puntuacion > 5) {
      return res.status(400).json({ msg: 'La puntuación debe ser un número entre 1 y 5' });
    }
    if (!user) {
      return res.status(400).json({ msg: 'Se requiere un usuario para votar' });
    }

    const recetaActualizada = await recetaService.valorarReceta(id, user, puntuacion);

    if (!recetaActualizada) {
      return res.status(404).json({ msg: 'Receta no encontrada' });
    }

    res.status(200).json(recetaActualizada);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
};

// ==========================================
// GET - OBTENER TOP RECETAS (RANKING)
// ==========================================
exports.obtenerMasValoradas = async (req, res) => {
  try {
    // Recogemos el límite por URL (ej: ?limit=5), si no viene, traemos 3
    const limite = req.query.limit ? parseInt(req.query.limit) : 3;

    const recetas = await recetaService.obtenerTopRecetas(limite);
    
    res.status(200).json(recetas);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};