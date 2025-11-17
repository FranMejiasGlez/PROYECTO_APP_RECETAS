const express = require("express");
const cors = require("cors");
require("dotenv").config();

const { connect } = require("./db");                 // ← conexión a Mongo
const recetasRoutes = require("./routes/recetasRoutes"); // ← tus rutas

const app = express();

// Middlewares
app.use(cors());
app.use(express.json());

// Conectar a MongoDB Atlas
connect()
  .then(() => console.log("Mongo listo"))
  .catch((err) => console.error("Error Mongo:", err));

// Ruta base
app.get("/", (req, res) => {
  res.send("API funcionando");
});

// Rutas de recetas
app.use("/api/recetas", recetasRoutes);

// Levantar servidor
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log("Servidor en puerto " + PORT));
