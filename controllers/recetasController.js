const { connect } = require("../db");
const { ObjectId } = require("mongodb");

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

exports.crear = async (req, res) => {
  try {
    const db = await connect();
    const raw = req.body;

    const receta = {
      nombre: raw.nombre,
      comensales: Number(raw.comensales),
      dificultad: Number(raw.dificultad),
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
    console.error(error);
    res.status(500).json({ mensaje: "Error al crear receta" });
  }
};

exports.actualizar = async (req, res) => {
  try {
    const db = await connect();

    const { value } = await db.collection("recetas").findOneAndUpdate(
      { _id: new ObjectId(req.params.id) },
      { $set: req.body },
      { returnDocument: "after" }
    );

    value
      ? res.json(value)
      : res.status(404).json({ mensaje: "No encontrado" });

  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: "Error al actualizar" });
  }
};

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
    res.status(500).json({ mensaje: "Error al eliminar" });
  }
};
