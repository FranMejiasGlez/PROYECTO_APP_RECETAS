const express = require('express');
const router = express.Router();
const comentariosController = require('../controllers/comentariosController');

// Crear comentario
router.post('/', comentariosController.crear);

// Obtener comentarios de una receta específica
// Ejemplo GET: /api/comentarios/receta/65a1b2c3d4e5...
router.get('/receta/:recetaId', comentariosController.obtenerDeReceta);

// Editar y Borrar por ID del comentario
router.put('/:id', comentariosController.editar);
router.delete('/:id', comentariosController.eliminar);

module.exports = router;