import 'package:flutter/material.dart';

class Carrusel extends StatelessWidget {
  const Carrusel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Añade Expanded aquí
      flex: 3,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Mas valorados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            // Cambia SizedBox por Expanded
            child: CarouselView(
              itemExtent: MediaQuery.sizeOf(context).width - 100,
              shrinkExtent: MediaQuery.sizeOf(context).width - 100,
              children: List.generate(10, (int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      'Receta ${index + 1}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
