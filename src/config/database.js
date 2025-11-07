// -------------------------------
// Configuración de Firebase Admin
// usando variables de entorno (.env)
// -------------------------------

import admin from "firebase-admin";
import dotenv from "dotenv";

// Carga las variables desde el archivo .env
dotenv.config();

// Inicializa la app de Firebase con credenciales del .env
admin.initializeApp({
  credential: admin.credential.cert({
    projectId: process.env.FIREBASE_PROJECT_ID,
    clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
    // 🔹 Los saltos de línea (\n) en la clave privada deben reemplazarse
    privateKey: process.env.FIREBASE_PRIVATE_KEY.replace(/\\n/g, "\n"),
  }),
});

// Crea una instancia de Firestore
const db = admin.firestore();

// Mensaje de confirmación en consola
console.log("✅ Conexión a Firestore inicializada correctamente (.env)");

// Exporta la instancia para usarla en controladores, rutas, etc.
export default db;
