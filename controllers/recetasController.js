const Receta = require("../models/Receta"); // Importamos el modelo nuevo

// ======================================================
// GET - OBTENER TODAS LAS RECETAS
// ======================================================
exports.obtenerTodos = async (req, res) => {
  try {
    // Mongoose: .find() directo sobre el modelo
    const recetas = await Receta.find();
    res.json(recetas);
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al obtener recetas", error: error.message });
  }
};

// ======================================================
// GET - OBTENER UNA RECETA POR ID
// ======================================================
exports.obtenerPorId = async (req, res) => {
  try {
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
  }
};

// ======================================================
// PUT - ACTUALIZAR RECETA
// ======================================================
exports.actualizar = async (req, res) => {
  try {
    const recetaActualizada = await Receta.findByIdAndUpdate(
      req.params.id,
      req.body, // Los datos nuevos
      { new: true } // Esto equivale a returnDocument: "after" (devuelve la nueva)
    );

    if (!recetaActualizada) {
      return res.status(404).json({ mensaje: "No encontrado" });
    }

    res.json(recetaActualizada);

  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al actualizar receta" });
  }
};

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

  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al eliminar receta" });
  }
};