import express from "express";
import TestRoutes from "../routes/TestRoutes.js"; // ✅ ahora sí, sube un nivel
const app = express();
app.use(express.json());
app.use("/api/test", TestRoutes);
export default app;
