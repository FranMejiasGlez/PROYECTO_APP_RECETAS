const express = require("express");
const cors = require("cors");
const { connect } = require("./db");  // conexión MongoDB
require("dotenv").config();
const app = express();

const recetasRoutes = require("./routes/recetasRoutes");



// Habilitar CORS para todos
app.use(cors());
app.use(express.json());

// RUTA PRINCIPAL DE LA API
app.use("/api/recetas", recetasRoutes);

// Conectar a Mongo
connect().then(() => {
    app.listen(3000, () => {
        console.log('Servidor escuchando en el puerto 3000');
    });
});