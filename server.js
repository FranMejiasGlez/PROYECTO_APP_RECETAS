const express = require("express");
const { connect } = require("./db");  // conexión MongoDB
require("dotenv").config();

const recetasRoutes = require("./routes/recetasRoutes");

const app = express();
app.use(express.json());

// RUTA PRINCIPAL DE LA API
app.use("/api/recetas", recetasRoutes);

// Conectar a Mongo
connect()
  .then(() => console.log("Mongo listo"))
  .catch((err) => console.error("Error conectando:", err));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log("Servidor en puerto " + PORT));
