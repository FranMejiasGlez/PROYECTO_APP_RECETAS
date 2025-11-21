import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Necesario para PointerDeviceKind

class RecipeCarousel extends StatelessWidget {
  final String title;
  final List<String> recipes;
  final Function(int)? onRecipeTap;

  const RecipeCarousel({
    Key? key,
    required this.title,
    required this.recipes,
    this.onRecipeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 400,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
            ),
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: PageController(viewportFraction: 0.8),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final String recipeName = recipes[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // --- CAPA 1: FONDO (IMAGEN) ---
                        Image.network(
                          "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480_1_5x/img/recipe/ras/Assets/4ADF5D92-29D0-4EB7-8C8B-5C7DAA0DA74A/Derivates/E5E1004A-1FF0-448B-87AF-31393870B653.jpg",
                          fit: BoxFit
                              .cover, // IMPORTANTE: Para que cubra toda la tarjeta
                        ),

                        // --- CAPA 2: CONTENIDO CON FONDO OSCURO ---
                        Center(
                          child: Container(
                            // Este margen es para que la caja negra no toque los bordes de la tarjeta
                            margin: const EdgeInsets.all(16.0),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 12.0,
                            ),
                            decoration: BoxDecoration(
                              // Fondo negro semitransparente
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            // mainAxisSize: MainAxisSize.min hace que la caja se ajuste al tamaño del texto
                            child: Column(
                              mainAxisSize: MainAxisSize.min,

                              children: [
                                // TEXTO 1: Nombre de la receta
                                Text(
                                  recipeName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 3.0,
                                        color: Colors.black26,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ), // Espacio entre textos
                              ],
                            ),
                          ),
                        ),

                        // --- CAPA 3: INTERACCIÓN ---
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (onRecipeTap != null) {
                                  onRecipeTap!(index);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
