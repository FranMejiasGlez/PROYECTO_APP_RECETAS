const express = require('express');
const router = express.Router();
const moviesController = require('../controllers/recetasController');

router.get('/', moviesController.obtenerTodos);
router.get('/:id', moviesController.obtenerPorId);
router.post('/', moviesController.crear);
router.put('/:id', moviesController.actualizar);
router.delete('/:id', moviesController.eliminar);

module.exports = router;