const mongoose = require("mongoose");
const { Schema, model } = mongoose;

const userSchema = new Schema(
  {
    username: { 
      type: String, 
      required: true, 
      unique: true 
    },
    email: { 
      type: String, 
      required: true, 
      unique: true 
    },
    password: { 
      type: String, 
      required: true 
    },
    
    // Nombres exactos según tu base de datos (snake_case)
    profile_image: { 
      type: String, 
      default: "" 
    },
    bio: { 
      type: String, 
      default: "" 
    },

    // Arrays de referencias (IDs)
    recetas_guardadas: {
      type: [{ type: Schema.Types.ObjectId, ref: 'Receta' }], // Relación con Recetas
      default: []
    },
    siguiendo: {
      type: [{ type: Schema.Types.ObjectId, ref: 'User' }],   // Relación con otros Usuarios
      default: []
    },
    seguidores: {
      type: [{ type: Schema.Types.ObjectId, ref: 'User' }],   // Relación con otros Usuarios
      default: []
    }
  },
  {
    // Opciones
    timestamps: true,      // Crea createdAt y updatedAt automáticamente
    collection: "usuarios", // Fuerza minúsculas para que no cree "Usuarios"
    versionKey: false      // Quita el __v
  }
);

module.exports = model("User", userSchema);