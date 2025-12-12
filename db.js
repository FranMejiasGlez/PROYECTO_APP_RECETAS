const mongoose = require('mongoose');
//MongoDB andyjan24_db_user IlN2A2EzlXppep0l


const uri = "mongodb+srv://andyjan24_db_user:VPrkJ9hQxAwZt6mk@migaz.ekuaaaf.mongodb.net/migaz?appName=Migaz";

async function connect() {
  try {
    // Intentamos conectar con las opciones predeterminadas de Mongoose
    await mongoose.connect(uri);
    
    console.log("¡MongoDB conectado exitosamente vía Mongoose!");
    
  } catch (err) {
    console.error("Error de conexión a MongoDB:", err);
    // Si falla la conexión crítica, cerramos el proceso para evitar que la app corra sin BD
    process.exit(1); 
  }
}

module.exports = { connect };