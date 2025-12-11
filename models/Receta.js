const mongoose = require("mongoose");

const recetaSchema = new mongoose.Schema(
  {
    nombre: { type: String, required: true },
    comensales: { type: Number, required: true }, // Mongoose maneja Int32 como Number
    dificultad: { type: String, required: true },
    categoria: { type: String, required: true },
    tiempo: { type: String, required: true }, // O Number, según cómo lo guardes
    ingredientes: { type: [String], default: [] }, // Array de strings
    instrucciones: { type: [String], default: [] } // Array de strings
  },
  {
    collection: "recetas", // Nombre exacto de tu colección en Mongo
    timestamps: true       // Crea createdAt y updatedAt automático
  }
);

module.exports = mongoose.model("Receta", recetaSchema);