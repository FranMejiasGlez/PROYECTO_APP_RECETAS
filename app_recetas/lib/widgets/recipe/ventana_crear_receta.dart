import 'package:flutter/material.dart';

class DialogoCrearReceta extends StatefulWidget {
  // ahora onGuardar recibe también la lista de pasos

  // lista de categorías permitidas (dominio cerrado)
  final List<String> categorias;

  // lista de dificultades permitidas
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _urlImagen = TextEditingController();
  final TextEditingController _urlYoutube = TextEditingController();
  final TextEditingController _tiempoPreparacion = TextEditingController();
  final TextEditingController _servings = TextEditingController();

  // ingredientes
  final List<String> _ingredientes = [];
  final TextEditingController _ingredienteController = TextEditingController();

  // pasos
  final List<String> _pasos = [];
  final TextEditingController _pasoController = TextEditingController();

  // categoría y dificultad seleccionadas
  String? _categoriaSeleccionada;
  String? _dificultadSeleccionada;

  @override
  void initState() {
    super.initState();
    _categoriaSeleccionada = widget.categorias.isNotEmpty
        ? widget.categorias.first
        : null;
    _dificultadSeleccionada = widget.dificultades.isNotEmpty
        ? widget.dificultades.first
        : null;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _urlImagen.dispose();
    _urlYoutube.dispose();
    _tiempoPreparacion.dispose();
    _servings.dispose();
    _ingredienteController.dispose();
    _pasoController.dispose();
    super.dispose();
  }

  void _agregarIngrediente() {
    final text = _ingredienteController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _ingredientes.add(text);
      _ingredienteController.clear();
    });
  }

  void _eliminarIngrediente(int index) {
    setState(() {
      _ingredientes.removeAt(index);
    });
  }

  void _agregarPaso() {
    final text = _pasoController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _pasos.add(text);
      _pasoController.clear();
    });
  }

  void _eliminarPaso(int index) {
    setState(() {
      _pasos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // tamaño fijo pero adaptable a pantallas pequeñas
    final double maxWidth = MediaQuery.of(context).size.width;
    final double dialogWidth = maxWidth > 700 ? 700 : maxWidth * 0.95;
    final double dialogHeight = MediaQuery.of(context).size.height * 0.7;

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: SizedBox(
        width: dialogWidth,
        height: dialogHeight,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: "Nombre de la receta",
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Introduce un nombre"
                      : null,
                ),
                TextFormField(
                  controller: _descripcionController,
                  decoration: const InputDecoration(labelText: "Descripción"),
                  validator: (value) => value == null || value.isEmpty
                      ? "Introduce una descripción"
                      : null,
                ),
                const SizedBox(height: 12),

                // ingredientes
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ingredienteController,
                        decoration: const InputDecoration(
                          labelText: 'Ingrediente',
                          hintText: 'p. ej. 200g harina',
                        ),
                        onSubmitted: (_) => _agregarIngrediente(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _agregarIngrediente,
                      child: const Text('Añadir'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (_ingredientes.isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(_ingredientes.length, (index) {
                        final ing = _ingredientes[index];
                        return InputChip(
                          label: Text(ing),
                          onDeleted: () => _eliminarIngrediente(index),
                        );
                      }),
                    ),
                  ),

                const SizedBox(height: 12),

                // pasos (añadir uno a uno, numerados)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _pasoController,
                        decoration: const InputDecoration(
                          labelText: 'Paso',
                          hintText: 'Describe el paso...',
                        ),
                        onSubmitted: (_) => _agregarPaso(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _agregarPaso,
                      child: const Text('Añadir paso'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (_pasos.isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(_pasos.length, (index) {
                        final step = _pasos[index];
                        // mostrar numerado y permitir borrado
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: InputChip(
                            label: Text('${index + 1}. $step'),
                            onDeleted: () => _eliminarPaso(index),
                          ),
                        );
                      }),
                    ),
                  ),

                const SizedBox(height: 12),

                // Dropdown categoría
                DropdownButtonFormField<String>(
                  initialValue: _categoriaSeleccionada,
                  decoration: const InputDecoration(labelText: 'Categoría'),
                  items: widget.categorias
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => _categoriaSeleccionada = v),
                  validator: (v) => v == null || v.isEmpty
                      ? 'Selecciona una categoría'
                      : null,
                ),

                const SizedBox(height: 12),

                // Dropdown dificultad
                DropdownButtonFormField<String>(
                  initialValue: _dificultadSeleccionada,
                  decoration: const InputDecoration(labelText: 'Dificultad'),
                  items: widget.dificultades
                      .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                      .toList(),
                  onChanged: (v) => setState(() => _dificultadSeleccionada = v),
                  validator: (v) => v == null || v.isEmpty
                      ? 'Selecciona una dificultad'
                      : null,
                ),

                const SizedBox(height: 12),
                TextFormField(
                  controller: _urlImagen,
                  decoration: const InputDecoration(labelText: "URL IMAGEN"),
                ),
                TextFormField(
                  controller: _urlYoutube,
                  decoration: const InputDecoration(labelText: "URL Youtube"),
                ),
                TextFormField(
                  controller: _tiempoPreparacion,
                  decoration: const InputDecoration(
                    labelText: "Tiempo de preparación",
                  ),
                ),
                TextFormField(
                  controller: _servings,
                  decoration: const InputDecoration(labelText: "Servings"),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancelar"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text("Guardar"),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
