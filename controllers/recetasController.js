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
    const nuevo = await recetasService.crear(req.body);
    res.status(201).json(nuevo);
};

exports.actualizar = async (req, res) => {
    const actualizado = await recetasService.actualizar(req.params.id, req.body);
    actualizado ? res.json(actualizado) : res.status(404).json({ mensaje: 'No encontrado' });
};

exports.eliminar = async (req, res) => {
    const eliminado = await recetasService.eliminar(req.params.id);
    eliminado ? res.json(eliminado) : res.status(404).json({ mensaje: 'No encontrado' });
};
