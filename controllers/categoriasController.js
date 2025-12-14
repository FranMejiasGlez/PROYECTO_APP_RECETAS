const Categoria = require('../models/categoriaModelo');

// Obtener todas (para el dropdown del frontend)
exports.obtenerTodas = async (req, res) => {
  try {
    const categorias = await Categoria.find().sort({ nombre: 1 });
    res.status(200).json(categorias);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Crear nueva categoría (Admin)
exports.crear = async (req, res) => {
  try {
    const nuevaCategoria = new Categoria(req.body);
    await nuevaCategoria.save();
    res.status(201).json(nuevaCategoria);
  } catch (error) {
    if (error.code === 11000) {
        return res.status(400).json({ msg: 'La categoría ya existe' });
    }
    res.status(500).json({ error: error.message });
  }
};