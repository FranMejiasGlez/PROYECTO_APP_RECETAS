const express = require("express");
const cors = require("cors");
const { connect } = require("./db");  // conexión MongoDB
require("dotenv").config();
const app = express();

const recetasRoutes = require("./routes/recetasRoutes");
const comentariosRoutes = require("./routes/comentariosRoutes");



// Habilitar CORS para todos
app.use(cors());
app.use(express.json());

// --- DEFINIR RUTAS (ENDPOINTS) ---
app.use("/api/recetas", recetasRoutes);
app.use("/api/comentarios", comentariosRoutes);
app.use('/img', express.static('img'));

// Conectar a Mongo
connect().then(() => {
    app.listen(3000, () => {
        console.log('Servidor escuchando en el puerto 3000');
    });
});