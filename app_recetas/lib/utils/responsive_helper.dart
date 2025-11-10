import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;

  ResponsiveHelper(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

  double get scale {
    return screenWidth > 768 ? (screenWidth / 768).clamp(1.0, 1.4) : 1.0;
  }

  double get maxWidth {
    if (screenWidth > 1200) return 700.0;
    if (screenWidth > 768) return 600.0;
    return 500.0;
  }

  bool get needsScroll => screenHeight <= 640;
  bool get isTablet => screenWidth >= 768;
  bool get isDesktop => screenWidth >= 1200;
}
