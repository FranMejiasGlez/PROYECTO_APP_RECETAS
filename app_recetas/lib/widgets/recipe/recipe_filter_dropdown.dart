import 'package:flutter/material.dart';

class RecipeFilterDropdown extends StatelessWidget {
  final String value;
  final List<String> categories;
  final ValueChanged<String?> onChanged;

  const RecipeFilterDropdown({
    Key? key,
    required this.value,
    required this.categories,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down, size: 20),
          style: const TextStyle(color: Colors.black, fontSize: 14),
          items: categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category == 'Todos' ? 'Todas las categorías' : category),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}