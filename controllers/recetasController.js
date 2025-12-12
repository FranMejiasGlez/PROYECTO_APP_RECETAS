<<<<<<< HEAD
const Receta = require("../models/Receta"); // Importamos el modelo nuevo
=======
// controllers/recetasController.js
const recetaService = require('../services/recetasServices'); // Asegúrate que la ruta sea correcta
>>>>>>> 751939197e9af9ccd065d1fa3969a0d2d6bdd7f8

exports.obtenerTodos = async (req, res) => {
  try {
<<<<<<< HEAD
    // Mongoose: .find() directo sobre el modelo
    const recetas = await Receta.find();
    res.json(recetas);
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al obtener recetas", error: error.message });
=======
    const recetas = await recetaService.obtenerTodasLasRecetas();
    res.status(200).json(recetas);
  } catch (error) {
    res.status(500).json({ error: error.message });
>>>>>>> 751939197e9af9ccd065d1fa3969a0d2d6bdd7f8
  }
};

exports.obtenerPorId = async (req, res) => {
  try {
<<<<<<< HEAD
    // Mongoose traduce el string del ID a ObjectId automáticamente
    const receta = await Receta.findById(req.params.id);

    if (!receta) {
      return res.status(404).json({ mensaje: "No encontrado" });
    }
    res.json(receta);
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al obtener receta", error: error.message });
  }
};

// ======================================================
// POST - CREAR UNA RECETA
// ======================================================
exports.crear = async (req, res) => {
  try {
    // Mongoose valida los tipos (Number, String, etc) usando el Modelo
    const nuevaReceta = new Receta(req.body);
    
    const recetaGuardada = await nuevaReceta.save();

    res.status(201).json({
      mensaje: "Receta creada",
      id: recetaGuardada._id,
      receta: recetaGuardada
    });

  } catch (error) {
    console.error("ERROR AL GUARDAR:", error.message);
    res.status(400).json({ mensaje: "Error al crear receta", detalle: error.message });
=======
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
    const nuevaReceta = await recetaService.crearReceta(req.body, req.files);
    res.status(201).json(nuevaReceta);

  } catch (error) {
    // Este catch solo saltará si:
    // 1. Se cae la base de datos.
    // 2. El Validator dejó pasar algo que Mongoose rechazó (nuestra "segunda barrera").
    console.error(error); 
    res.status(400).json({ msg: 'Error al procesar la receta', error: error.message });
>>>>>>> 751939197e9af9ccd065d1fa3969a0d2d6bdd7f8
  }
};

exports.actualizar = async (req, res) => {
  try {
<<<<<<< HEAD
    const recetaActualizada = await Receta.findByIdAndUpdate(
      req.params.id,
      req.body, // Los datos nuevos
      { new: true } // Esto equivale a returnDocument: "after" (devuelve la nueva)
    );

    if (!recetaActualizada) {
      return res.status(404).json({ mensaje: "No encontrado" });
    }

    res.json(recetaActualizada);

=======
    const recetaActualizada = await recetaService.actualizarReceta(req.params.id, req.body, req.files);
    if (!recetaActualizada) {
      return res.status(404).json({ msg: 'Receta no encontrada' });
    }
    res.status(200).json(recetaActualizada);
>>>>>>> 751939197e9af9ccd065d1fa3969a0d2d6bdd7f8
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

<<<<<<< HEAD
// ======================================================
// DELETE - ELIMINAR RECETA
// ======================================================
exports.eliminar = async (req, res) => {
  try {
    const resultado = await Receta.findByIdAndDelete(req.params.id);

    if (!resultado) {
      return res.status(404).json({ mensaje: "No encontrado" });
    }

    res.json({ mensaje: "Eliminado correctamente" });

=======
exports.eliminar = async (req, res) => {
  try {
    const recetaEliminada = await recetaService.eliminarReceta(req.params.id);
    if (!recetaEliminada) {
      return res.status(404).json({ msg: 'Receta no encontrada' });
    }
    res.status(200).json({ msg: 'Receta eliminada correctamente' });
>>>>>>> 751939197e9af9ccd065d1fa3969a0d2d6bdd7f8
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
<<<<<<< HEAD
=======
};

exports.valorar = async (req, res) => {
  try {
    const { id } = req.params;
    const { puntuacion, user } = req.body;

    // Validación básica
    if (!puntuacion || puntuacion < 1 || puntuacion > 5) {
      return res.status(400).json({ msg: 'La puntuación debe ser un número entre 1 y 5' });
    }
    if (!user) {
      return res.status(400).json({ msg: 'Se requiere un usuario para votar' });
    }

    // Llamamos al servicio
    const recetaActualizada = await recetaService.valorarReceta(id, user, puntuacion);

    if (!recetaActualizada) {
      return res.status(404).json({ msg: 'Receta no encontrada' });
    }

    res.status(200).json(recetaActualizada);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: error.message });
  }
>>>>>>> 751939197e9af9ccd065d1fa3969a0d2d6bdd7f8
};