const express = require('express');
const router = express.Router();
const recetasController = require('../controllers/recetasController');

router.get('/', recetasController.obtenerTodos);
router.get('/:id', recetasController.obtenerPorId);
router.post('/', recetasController.crear);
router.put('/:id', recetasController.actualizar);
router.delete('/:id', recetasController.eliminar);

module.exports = router;