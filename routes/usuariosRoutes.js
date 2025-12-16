const express = require('express');
const router = express.Router();
const usuariosController = require('../controllers/usuariosController');
// Rutas públicas
router.get('/', usuariosController.obtenerTodos);
router.get('/buscar/:username', usuariosController.buscarPorUsername);
router.get('/:id', usuariosController.perfil);

//Importar Middleware de Subida
const upload = require('../middlewares/upload');

router.post('/registro', usuariosController.registrar);
router.post('/login', usuariosController.login);
router.post('/:id/seguir', usuariosController.seguirUsuario);
router.post('/:id/guardar-receta', usuariosController.guardarReceta); // Body: { "recetaId": "..." }

router.put('/:id', upload.single('imagen'), usuariosController.actualizar); // Cambiar bio, username, pass, FOTO


module.exports = router;