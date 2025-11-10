// controllers/moviesController.js
const moviesService = require('../services/moviesServices');

exports.obtenerTodos = async (req, res) => {
    const movies = await moviesService.listar();
    res.json(movies);
};

exports.obtenerPorId = async (req, res) => {
    const movie = await moviesService.buscarPorId(req.params.id);
    movie ? res.json(movie) : res.status(404).json({ mensaje: 'No encontrado' });
};

exports.crear = async (req, res) => {
    const nuevo = await moviesService.crear(req.body);
    res.status(201).json(nuevo);
};

exports.actualizar = async (req, res) => {
    const actualizado = await moviesService.actualizar(req.params.id, req.body);
    actualizado ? res.json(actualizado) : res.status(404).json({ mensaje: 'No encontrado' });
};

exports.eliminar = async (req, res) => {
    const eliminado = await moviesService.eliminar(req.params.id);
    eliminado ? res.json(eliminado) : res.status(404).json({ mensaje: 'No encontrado' });
};
