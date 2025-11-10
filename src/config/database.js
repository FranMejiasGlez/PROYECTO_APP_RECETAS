// src/config/database.js
import admin from "firebase-admin";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 📍 El JSON está en src/serviceAccountKey.json
const serviceAccountPath = path.resolve(__dirname, "../serviceAccountKey.json");

console.log("🧭 Cargando credenciales desde:", serviceAccountPath);

// ✅ Leemos y parseamos el JSON antes de pasarlo a Firebase
const serviceAccount = JSON.parse(fs.readFileSync(serviceAccountPath, "utf8"));

// Inicializamos Firebase correctamente con el objeto ya parseado
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

console.log(`✅ Firebase conectado correctamente al proyecto: ${serviceAccount.project_id}`);

export { db, admin };
