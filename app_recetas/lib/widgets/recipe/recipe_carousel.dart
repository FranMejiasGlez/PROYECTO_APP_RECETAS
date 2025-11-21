import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Necesario para PointerDeviceKind
import 'package:app_recetas/utils/app_theme.dart';

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
          // 1. AÑADIDO: Configuración para permitir arrastrar con ratón y dedo
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind
                    .mouse, // <--- ESTO permite arrastrar con el ratón
              },
            ),
            child: PageView.builder(
              // 2. AÑADIDO: BouncingScrollPhysics da un tacto más natural
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
                        // --- CAPA 1: FONDO ---
                        Container(
                          child: Image.network(
                            "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480_1_5x/img/recipe/ras/Assets/4ADF5D92-29D0-4EB7-8C8B-5C7DAA0DA74A/Derivates/E5E1004A-1FF0-448B-87AF-31393870B653.jpg",
                          ),
                        ),

                        // --- CAPA 2: CONTENIDO ---
                        Center(
                          child: Container(
                            // 1. Añadimos un margen interno al contenedor del fondo
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            decoration: BoxDecoration(
                              // 2. AQUÍ ESTÁ EL TRUCO: Color negro con opacidad (0.5 es 50% transparente)
                              color: Colors.black.withOpacity(0.5),
                              // 3. Opcional: Bordes redondeados para que quede más bonito
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              recipeName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                // Mantener la sombra ayuda aún más a la lectura
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 3.0,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
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
