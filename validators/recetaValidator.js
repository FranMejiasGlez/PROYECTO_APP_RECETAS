const { check, validationResult } = require('express-validator');

const validarResultados = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    // Si hay errores, devolvemos un 400 y la lista de fallos
    return res.status(400).json({ errors: errors.array() });
  }
  next(); // Si todo está bien, pasamos al Controlador
};

const validatorCrearReceta = [
check('nombre').exists().notEmpty().withMessage('El nombre es obligatorio'),
  
  // IMPORTANTE: .toInt() convierte el string "3" a número 3 antes de llegar al controlador
  check('comensales')
    .exists()
    .isInt({ min: 1 }).withMessage('Comensales debe ser un número entero mayor a 0')
    .toInt(), 

  check('dificultad')
    .exists()
    .isInt({ min: 1, max: 5 }).withMessage('La dificultad debe ser entre 1 y 5')
    .toInt(),

  check('ingredientes')
    .isArray({ min: 1 }).withMessage('Añade al menos un ingrediente'),

  check('instrucciones')
    .isArray({ min: 1 }).withMessage('Añade al menos una instrucción'),

  (req, res, next) => {
    validarResultados(req, res, next);
  }
];

module.exports = { validatorCrearReceta };