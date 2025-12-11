const express = require('express');
const router = express.Router();
const recetasController = require('../controllers/recetasController');
// validador
const { validatorCrearReceta } = require('../validators/recetaValidator');

router.get('/', recetasController.obtenerTodos);
router.get('/:id', recetasController.obtenerPorId);

// inyectamos el middleware antes de llamar al controlador
router.post('/', validatorCrearReceta, recetasController.crear);

router.put('/:id', recetasController.actualizar);
router.delete('/:id', recetasController.eliminar);

module.exports = router;