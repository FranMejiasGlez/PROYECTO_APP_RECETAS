import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryYellow = Color(0xFFFEC601);
  static const Color tealGreen = Color(0xFF25CCAD);
  static const Color orange = Color(0xFFEA7317);

  static LinearGradient get appGradient {
    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment(0.8, 1),
      colors: [tealGreen, primaryYellow, orange],
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryYellow,
      scaffoldBackgroundColor: Colors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryYellow,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
