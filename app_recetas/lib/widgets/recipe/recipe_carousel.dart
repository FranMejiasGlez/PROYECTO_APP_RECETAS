import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
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
          height: 200, // Altura ajustada para que se vea bien
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              scrollbars: false,
            ),
            child: CarouselView(
              itemExtent: MediaQuery.sizeOf(context).width * 0.8,
              children: recipes.asMap().entries.map((entry) {
                final int index = entry.key;
                final String recipeName = entry.value;

                return Card(
                  clipBehavior: Clip
                      .antiAlias, // Necesario para que el InkWell respete los bordes redondos
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: InkWell(
                    // InkWell es mucho más fiable para detectar toques en Cards
                    onTap: () {
                      if (onRecipeTap != null) {
                        onRecipeTap!(index);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // Un gradiente suave o color sólido para que se vea profesional
                        gradient: AppTheme.appGradient,
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
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
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
