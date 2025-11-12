import 'package:app_recetas/model/recipe.dart';
import 'package:flutter/material.dart';

class DialogoCrearReceta extends StatefulWidget {
  final List<String> categorias;
  final List<String> dificultades;

  const DialogoCrearReceta({
    Key? key,
    required this.categorias,
    required this.dificultades,
  }) : super(key: key);

  @override
  State<DialogoCrearReceta> createState() => _DialogoCrearRecetaState();
}

class _DialogoCrearRecetaState extends State<DialogoCrearReceta> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _servingsController = TextEditingController(
    text: '1',
  );

  // Ingredientes y pasos (listas manejadas uno a uno)
  final TextEditingController _ingredienteInputController =
      TextEditingController();
  final List<String> _ingredientes = [];

  final TextEditingController _pasoInputController = TextEditingController();
  final List<String> _pasos = [];

  final TextEditingController _youtubeController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  String _categoriaSeleccionada = '';
  String _dificultadSeleccionada = '';
  double _valoracion = 0.0;

  @override
  void initState() {
    super.initState();
    _categoriaSeleccionada = widget.categorias.isNotEmpty
        ? widget.categorias.first
        : 'Otros';
    _dificultadSeleccionada = widget.dificultades.isNotEmpty
        ? widget.dificultades.first
        : 'Todos los niveles';
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _servingsController.dispose();
    _ingredienteInputController.dispose();
    _pasoInputController.dispose();
    _youtubeController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _agregarIngrediente() {
    final text = _ingredienteInputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _ingredientes.add(text);
      _ingredienteInputController.clear();
    });
  }

  void _quitarIngrediente(int index) {
    setState(() => _ingredientes.removeAt(index));
  }

  void _agregarPaso() {
    final text = _pasoInputController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _pasos.add(text);
      _pasoInputController.clear();
    });
  }

  void _quitarPaso(int index) {
    setState(() => _pasos.removeAt(index));
  }

  void _onGuardar() {
    final nombre = _nombreController.text.trim();
    if (nombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Introduce un nombre para la receta')),
      );
      return;
    }

    final servings = int.tryParse(_servingsController.text.trim()) ?? 1;

    final nueva = Recipe(
      nombre: nombre,
      categoria: _categoriaSeleccionada,
      valoracion: _valoracion,
      descripcion: _descripcionController.text.trim(),
      dificultad: _dificultadSeleccionada,
      servings: servings,
      pasos: List<String>.from(_pasos),
      ingredientes: List<String>.from(_ingredientes),
      youtubeUrl: _youtubeController.text.trim().isEmpty
          ? null
          : _youtubeController.text.trim(),
      imageUrl: _imageController.text.trim().isEmpty
          ? null
          : _imageController.text.trim(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Receta "${nueva.toString()}" creada')),
    );
    //print('Nueva receta creada: $nueva');
    Navigator.of(context).pop(nueva);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Crear nueva receta'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _categoriaSeleccionada,
              items: widget.categorias
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(
                () => _categoriaSeleccionada = v ?? _categoriaSeleccionada,
              ),
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _dificultadSeleccionada,
              items: widget.dificultades
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (v) => setState(
                () => _dificultadSeleccionada = v ?? _dificultadSeleccionada,
              ),
              decoration: const InputDecoration(labelText: 'Dificultad'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _servingsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Raciones (servings)',
              ),
            ),
            const SizedBox(height: 12),

            // Ingredientes: input + add button + chips list
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Ingredientes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _ingredienteInputController,
                    decoration: const InputDecoration(
                      hintText: 'Añadir ingrediente',
                    ),
                    onSubmitted: (_) => _agregarIngrediente(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _agregarIngrediente,
                  child: const Text('Agregar'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_ingredientes.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: List.generate(_ingredientes.length, (i) {
                  final ing = _ingredientes[i];
                  return Chip(
                    label: Text(ing),
                    onDeleted: () => _quitarIngrediente(i),
                  );
                }),
              ),

            const SizedBox(height: 12),

            // Pasos: input + add + numbered list
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Pasos',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pasoInputController,
                    decoration: const InputDecoration(
                      hintText: 'Escribir paso',
                    ),
                    onSubmitted: (_) => _agregarPaso(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _agregarPaso,
                  child: const Text('Agregar'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_pasos.isNotEmpty)
              Column(
                children: List.generate(_pasos.length, (i) {
                  final paso = _pasos[i];
                  return ListTile(
                    leading: CircleAvatar(child: Text((i + 1).toString())),
                    title: Text(paso),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _quitarPaso(i),
                    ),
                  );
                }),
              ),

            const SizedBox(height: 12),

            // URLs: Youtube e Imagen
            TextField(
              controller: _youtubeController,
              decoration: const InputDecoration(
                labelText: 'URL YouTube (video)',
              ),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'URL imagen'),
              keyboardType: TextInputType.url,
            ),

            /*  const SizedBox(height: 12),
            Row(
              children: [
                const Text('Valoración'),
                const SizedBox(width: 8),
                Expanded(
                  child: Slider(
                    value: _valoracion,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    label: _valoracion.toStringAsFixed(1),
                    onChanged: (v) => setState(() => _valoracion = v),
                  ),
                ),
              ],
            ),*/
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(onPressed: _onGuardar, child: const Text('Guardar')),
      ],
    );
  }
}
