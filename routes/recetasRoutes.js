const express = require('express');
const router = express.Router();
const recetasController = require('../controllers/recetasController');
const upload = require('../middlewares/upload');
// validador
const { validatorCrearReceta } = require('../validators/recetaValidator');

router.get('/', recetasController.obtenerTodos);
router.get('/:id', recetasController.obtenerPorId);

// inyectamos el middleware antes de llamar al controlador
router.post('/', upload.array('imagenes', 5), validatorCrearReceta, recetasController.crear);
router.post('/:id/valorar', recetasController.valorar);

router.put('/:id', upload.array('imagenes', 5), recetasController.actualizar);
router.delete('/:id', recetasController.eliminar);


module.exports = router;