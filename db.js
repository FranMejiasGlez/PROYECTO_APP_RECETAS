

const mongoose = require('mongoose');

const uri = "mongodb+srv://andyjan24_db_user:VPrkJ9hQxAwZt6mk@migaz.ekuaaaf.mongodb.net/migaz?appName=Migaz";

const clientOptions = {
  serverApi: { version: '1', strict: true, deprecationErrors: true },
  family: 4 
};

const connect = async () => {
  try {
    console.log(" Conectando a MongoDB...");
    
    
    await mongoose.connect(uri, clientOptions);

    console.log(" Base de datos 'migaz' conectada con Mongoose");
  } catch (error) {
    console.error(" Error de conexión:", error.message);
    throw error;
  }
};

module.exports = { connect };