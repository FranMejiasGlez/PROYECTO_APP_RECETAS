const express = require('express');
const router = express.Router();
const usuariosController = require('../controllers/usuariosController');
const auth = require('../middleware/auth');
// Rutas públicas
router.get('/', usuariosController.obtenerTodos);


router.post('/registro', usuariosController.registrar);
router.post('/login', usuariosController.login);

router.use(auth);
router.post('/:id/seguir', usuariosController.seguirUsuario);
router.post('/:id/guardar-receta', usuariosController.guardarReceta); // Body: { "recetaId": "..." }
router.get('/:id', usuariosController.perfil);
router.put('/:id', usuariosController.actualizar); // Cambiar bio, username, pass


module.exports = router;