import db from "./config/database.js";

const test = async () => {
  try {
    // 🔹 Referencia a la colección de prueba
    const coleccion = db.collection("test");

    // 🔹 Crear (o sobreescribir) un documento
    const docRef = coleccion.doc("prueba1");
    await docRef.set({
      mensaje: "Hola Firestore desde Node con Admin SDK y .env 🎉",
      fecha: new Date().toISOString(),
    });

    console.log(" Documento guardado correctamente");

    // 🔹 Leer todos los documentos de la colección
    const snapshot = await coleccion.get();

    console.log(" Documentos en la colección:");
    snapshot.forEach((doc) => {
      console.log(`🆔 ${doc.id} →`, doc.data());
    });

    console.log(" Prueba completada con éxito");
  } catch (error) {
    console.error(" Error al acceder a Firestore:", error);
  }
};

test();
