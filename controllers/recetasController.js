const { connect } = require("../db");
const { ObjectId, Int32 } = require("mongodb");

// ======================================================
// GET - OBTENER TODAS LAS RECETAS
// ======================================================
exports.obtenerTodos = async (req, res) => {
  try {
    const db = await connect();
    const recetas = await db.collection("recetas").find().toArray();
    res.json(recetas);
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al obtener recetas" });
  }
};

// ======================================================
// GET - OBTENER UNA RECETA POR ID
// ======================================================
exports.obtenerPorId = async (req, res) => {
  try {
    const db = await connect();

    const receta = await db
      .collection("recetas")
      .findOne({ _id: new ObjectId(req.params.id) });

    receta
      ? res.json(receta)
      : res.status(404).json({ mensaje: "No encontrado" });

  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al obtener receta" });
  }
};

// ======================================================
// POST - CREAR UNA RECETA (ADAPTADO AL SCHEMA)
// ======================================================
exports.crear = async (req, res) => {
  try {
    const db = await connect();
    const raw = req.body;

    const receta = {
      _id: new ObjectId(),
      nombre: raw.nombre,
      comensales: new Int32(raw.comensales),  // int
      dificultad: String(raw.dificultad),     // string (schema lo exige)
      categoria: raw.categoria,               // obligatorio
      tiempo: raw.tiempo,
      ingredientes: Array.isArray(raw.ingredientes) ? raw.ingredientes : [],
      instrucciones: Array.isArray(raw.instrucciones) ? raw.instrucciones : []
    };

    const result = await db.collection("recetas").insertOne(receta);

    res.status(201).json({
      mensaje: "Receta creada",
      id: result.insertedId
    });

  } catch (error) {
    console.error(
      "SCHEMA VALIDATION ERROR:",
      JSON.stringify(error.errInfo, null, 2)
    );
    res.status(500).json({ mensaje: "Error al crear receta", detalle: error.errInfo });
  }
};

// ======================================================
// PUT - ACTUALIZAR RECETA
// ======================================================
exports.actualizar = async (req, res) => {
  try {
    const db = await connect();

    const result = await db.collection("recetas").findOneAndUpdate(
      { _id: new ObjectId(req.params.id) },
      { $set: req.body },
      {
        returnDocument: "after",   // devuelve el documento actualizado
        returnOriginal: false      // compatibilidad con versiones antiguas
      }
    );

    if (!result) {
      return res.status(404).json({ mensaje: "No encontrado" });
    }

    res.json(result);

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
    const db = await connect();

    const resultado = await db
      .collection("recetas")
      .deleteOne({ _id: new ObjectId(req.params.id) });

    resultado.deletedCount === 0
      ? res.status(404).json({ mensaje: "No encontrado" })
      : res.json({ mensaje: "Eliminado correctamente" });

  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al eliminar receta" });
  }
};
