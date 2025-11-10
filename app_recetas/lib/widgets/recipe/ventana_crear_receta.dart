import 'package:flutter/material.dart';

class DialogoCrearReceta extends StatefulWidget {
  final Function(String nombre, String descripcion) onGuardar;

  const DialogoCrearReceta({Key? key, required this.onGuardar})
    : super(key: key);

  @override
  State<DialogoCrearReceta> createState() => _DialogoCrearRecetaState();
}

class _DialogoCrearRecetaState extends State<DialogoCrearReceta> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text("Nueva receta"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: "Nombre de la receta",
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? "Introduce un nombre" : null,
            ),
            TextFormField(
              controller: _descripcionController,
              decoration: const InputDecoration(labelText: "Descripción"),
              validator: (value) => value == null || value.isEmpty
                  ? "Introduce una descripción"
                  : null,
            ),
          ],
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
              widget.onGuardar(
                _nombreController.text,
                _descripcionController.text,
              );
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
