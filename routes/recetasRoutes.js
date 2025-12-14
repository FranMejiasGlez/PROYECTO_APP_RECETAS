const express = require('express');
const router = express.Router();
//Importar Controlador
const recetasController = require('../controllers/recetasController');
//Importar Middleware de Subida (Multer)
const upload = require('../middlewares/upload'); 
//Importar el Validador (¡ESTA ES LA LÍNEA QUE TE FALTA!)
const { validatorCrearReceta } = require('../validators/recetaValidator');

router.get('/', recetasController.obtenerTodos);

router.get('/top', recetasController.obtenerMejorValoradas); 

// Rutas genéricas con ID van al final
router.get('/:id', recetasController.obtenerPorId);

router.post('/', upload.array('imagenes', 5), validatorCrearReceta, recetasController.crear);
router.put('/:id', upload.array('imagenes', 5), recetasController.actualizar);
router.delete('/:id', recetasController.eliminar);

// Ruta de valoración
router.post('/:id/valorar', recetasController.valorar);

module.exports = router;


module.exports = router;