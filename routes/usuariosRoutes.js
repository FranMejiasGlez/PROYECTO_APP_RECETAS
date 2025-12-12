const express = require('express');
const router = express.Router();
const usuariosController = require('../controllers/usuariosController');
// Rutas públicas
router.get('/', usuariosController.obtenerTodos);
router.get('/:id', usuariosController.perfil);

router.post('/registro', usuariosController.registrar);
router.post('/login', usuariosController.login);
router.post('/:id/seguir', usuariosController.seguirUsuario);
router.post('/:id/guardar-receta', usuariosController.guardarReceta); // Body: { "recetaId": "..." }

router.put('/:id', usuariosController.actualizar); // Cambiar bio, username, pass


module.exports = router;