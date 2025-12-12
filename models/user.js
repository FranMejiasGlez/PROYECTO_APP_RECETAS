const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    id: { type: String, required: true }, 
    username: { type: String, required: true },
    password:{type: String, required: true},
    email: { type: String, required: true }, 
    profileImage: { type: String, default: null },
    bio: { type: String, default: null },
  },
  {
    collection: "Usuarios", 
    timestamps: true,
    autoIndex: false, 
  }
);

module.exports = mongoose.model("User", userSchema);