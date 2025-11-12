import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';
import 'widgets/auth/user_credentials.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserCredentials(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Migaz - App de Recetas',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      // usa el mapa de rutas definido en config/routes.dart
      routes: AppRoutes.routes,
    );
  }
}
