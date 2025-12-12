const comentarioService = require('../services/comentariosServices');

// Crear
exports.crear = async (req, res) => {
  try {
    const { usuario, receta, contenido } = req.body;
    
    // Validación básica (podrías moverla a un validator aparte)
    if (!receta || !usuario || !contenido) {
      return res.status(400).json({ msg: 'Faltan datos obligatorios' });
    }

    const nuevoComentario = await comentarioService.crearComentario(req.body);
    res.status(201).json(nuevoComentario);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Obtener comentarios de una receta
exports.obtenerDeReceta = async (req, res) => {
  try {
    const { recetaId } = req.params;
    const comentarios = await comentarioService.obtenerPorReceta(recetaId);
    res.status(200).json(comentarios);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Editar
exports.editar = async (req, res) => {
  try {
    const { id } = req.params;
    const { contenido } = req.body;

    const comentarioEditado = await comentarioService.editarComentario(id, contenido);

    if (!comentarioEditado) {
      return res.status(404).json({ msg: 'Comentario no encontrado' });
    }

    res.status(200).json(comentarioEditado);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Eliminar
exports.eliminar = async (req, res) => {
  try {
    const { id } = req.params;
    const resultado = await comentarioService.eliminarComentario(id);

    if (!resultado) {
      return res.status(404).json({ msg: 'Comentario no encontrado' });
    }

    res.status(200).json({ msg: 'Comentario eliminado' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};