// -------------------------------
// Configuración de Express
// -------------------------------

import express from "express";
import cors from "cors";
import db from "./config/database.js"; // conexión a Firestore

const app = express();

// Middlewares
app.use(cors());
app.use(express.json());

// Ruta base de prueba
app.get("/", (req, res) => {
  res.send("🔥 API de Recetas funcionando correctamente");
});

app.get("/api/:coleccion", async (req, res) => {
  try {
    const { coleccion } = req.params;
    const snapshot = await db.collection(coleccion).get();
    const documentos = snapshot.docs.map((d) => ({ id: d.id, ...d.data() }));
    res.json({ ok: true, coleccion, total: documentos.length, data: documentos });
  } catch (error) {
    res.status(500).json({ ok: false, error: error.message });
  }
});

// Ruta para probar Firestore
app.get("/test-db", async (req, res) => {
  try {
    const snapshot = await db.collection("test").get();
    const docs = snapshot.docs.map((d) => ({ id: d.id, ...d.data() }));
    res.json({ ok: true, total: docs.length, data: docs });
  } catch (error) {
    console.error(" Error al conectar con Firestore:", error);
    res.status(500).json({ ok: false, error: error.message });
  }
});

export default app;
