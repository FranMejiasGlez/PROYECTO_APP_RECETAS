// controllers/recetasController.js
const recetasService = require('../services/recetasServices');

exports.obtenerTodos = async (req, res) => {
    const recetas = await recetasService.listar();
    res.json(recetas);
};

exports.obtenerPorId = async (req, res) => {
    const movie = await recetasService.buscarPorId(req.params.id);
    movie ? res.json(movie) : res.status(404).json({ mensaje: 'No encontrado' });
};

exports.crear = async (req, res) => {
    try {
    const raw = req.body;

    // Normalizar tipos
    const receta = {
      _id: new ObjectId(),
      nombre: raw.nombre,
      comensales: Number(raw.comensales),
      dificultad: Number(raw.dificultad),
      tiempo: raw.tiempo,
      ingredientes: Array.isArray(raw.ingredientes) ? raw.ingredientes : [],
      instrucciones: Array.isArray(raw.instrucciones) ? raw.instrucciones : []
    };

    const result = await collection.insertOne(receta);
    res.status(201).json({ insertedId: result.insertedId });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: err.message });
  }
};

exports.actualizar = async (req, res) => {
    const actualizado = await recetasService.actualizar(req.params.id, req.body);
    actualizado ? res.json(actualizado) : res.status(404).json({ mensaje: 'No encontrado' });
};

exports.eliminar = async (req, res) => {
    const eliminado = await recetasService.eliminar(req.params.id);
    eliminado ? res.json(eliminado) : res.status(404).json({ mensaje: 'No encontrado' });
};
