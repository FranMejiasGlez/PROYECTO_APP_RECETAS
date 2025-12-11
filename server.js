const express = require("express");
const { connect } = require("./db"); 
require("dotenv").config(); 
// --- IMPORTAR RUTAS ---
const recetasRoutes = require("./routes/recetasRoutes");
const userRoutes = require("./routes/usersRoutes"); 

const app = express();

// --- MIDDLEWARES ---
app.use(express.json()); 

// --- DEFINIR RUTAS (ENDPOINTS) ---
app.use("/api/recetas", recetasRoutes);
app.use("/api/users", userRoutes);

app.get("/", (req, res) => {
  res.send("API de Recetas funcionando correctamente ");
});

// --- CONFIGURACIÓN DEL PUERTO ---
const PORT = process.env.PORT || 3000;

// --- INICIO DEL SERVIDOR ---
console.log(" Iniciando conexión a MongoDB...");

connect()
  .then(() => {
    app.listen(PORT, () => {
      console.log(`SERVIDOR CORRIENDO EN: http://localhost:${PORT}`);
      console.log("Base de datos conectada y operativa.");
    });
  })
  .catch((err) => {
    console.error("ERROR FATAL: No se pudo conectar a MongoDB.");
    console.error("El servidor no se ha iniciado por seguridad.");
    console.error("Detalle:", err.message);
  });