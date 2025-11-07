import 'package:flutter/material.dart';
import 'config/routes.dart';

void main() {
  // Descomentar para Device Preview
  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const MiAplicacion(),
  // ));

  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Migaz - App de Recetas',
      debugShowCheckedModeBanner: false,

      // Para Device Preview
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
