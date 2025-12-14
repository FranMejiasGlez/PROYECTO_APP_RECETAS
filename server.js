const express = require("express");
const cors = require("cors");
const { connect } = require("./db");  
require("dotenv").config();

const app = express();

const recetasRoutes = require("./routes/recetasRoutes");
const comentariosRoutes = require("./routes/comentariosRoutes");
const usuariosRoutes = require("./routes/usuariosRoutes");
const categoriasRoutes = require("./routes/categoriasRoutes");

app.use(cors());
app.use(express.json());

app.use("/api/recetas", recetasRoutes);
app.use("/api/comentarios", comentariosRoutes);
app.use("/api/usuarios", usuariosRoutes);
app.use("/api/categorias", categoriasRoutes);
app.use('/img', express.static('img'));

connect().then(() => {
    app.listen(3000, () => {
        console.log('Servidor escuchando en el puerto 3000');
    });
});