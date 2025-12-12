const express = require('express');
const router = express.Router();
const categoriasController = require('../controllers/categoriasController');

router.get('/', categoriasController.obtenerTodas);
router.post('/', categoriasController.crear);

module.exports = router;