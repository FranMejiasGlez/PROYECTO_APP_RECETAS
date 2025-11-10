// services/moviesService.js
const { connect } = require('../db');
const { ObjectId } = require('mongodb');

async function getCollection() {
  const db = await connect();
  return db.collection('recetas'); // your collection name
}

exports.listar = async () => {
  const col = await getCollection();
  return col.find().limit(100).toArray(); // limit to 100 for safety
};

exports.buscarPorId = async (id) => {
  const col = await getCollection();
  return col.findOne({ _id: new ObjectId(id) });
};

exports.crear = async (nuevo) => {
  const col = await getCollection();
  const result = await col.insertOne(nuevo);
  return { ...nuevo, _id: result.insertedId };
};

exports.actualizar = async (id, cambios) => {
  const col = await getCollection();
  const result = await col.findOneAndUpdate(
    { _id: new ObjectId(id) },
    { $set: cambios },
    { returnDocument: 'after' }
  );
  return result.value; // null if not found
};

exports.eliminar = async (id) => {
  const col = await getCollection();
  const result = await col.findOneAndDelete({ _id: new ObjectId(id) });
  return result.value; // null if not found
};
