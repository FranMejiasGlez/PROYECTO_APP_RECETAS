import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class RecipeCarousel extends StatelessWidget {
  final String title;
  final List<String> recipes;

  const RecipeCarousel({Key? key, required this.title, required this.recipes})
    : super(key: key);

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
          height: 500,
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              scrollbars: false,
            ),
            child: CarouselView(
              itemExtent: MediaQuery.sizeOf(context).width * 0.7,
              children: recipes.map((recipe) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      recipe,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
