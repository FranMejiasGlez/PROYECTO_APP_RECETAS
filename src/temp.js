import dotenv from "dotenv";
dotenv.config();
console.log("PRIVATE_KEY:", process.env.PRIVATE_KEY ? "✅ encontrada" : "❌ no encontrada");
