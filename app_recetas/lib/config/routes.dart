import 'package:app_recetas/screens/pantalla_biblioteca.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/pantalla_recetas.dart';
import '../screens/pantalla_perfiluser.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String home = '/home';
  static const String biblioteca = '/biblioteca';
  static const String perfilUser = '/perfil';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      home: (context) => const PantallaRecetas(),
      biblioteca: (context) => const PantallaBiblioteca(),
      perfilUser: (context) => const PantallaPerfilUser(),
    };
  }
}
