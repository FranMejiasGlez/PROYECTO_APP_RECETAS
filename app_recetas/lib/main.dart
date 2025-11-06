import 'package:app_recetas/pantallaRecetas.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  DevicePreview(enabled: !kReleaseMode, builder: (context) => _MiAplicacion()),
);

class _MiAplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: _Login(),
    );
  }
}

// --- Pantalla Principal Login ---
class _Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Escalar basado en el ancho
    final scale = screenWidth > 768 ? (screenWidth / 768).clamp(1.0, 1.4) : 1.0;

    // Ancho máximo adaptativo
    final maxWidth = screenWidth > 1200
        ? 700.0
        : (screenWidth > 768 ? 600.0 : 500.0);

    // Determinar si necesitamos scroll (pantallas muy pequeñas)
    final needsScroll = screenHeight <= 640;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xFF25CCAD),
              Color(0xFFFEC601),
              Color(0xFFEA7317),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: needsScroll
                ? SingleChildScrollView(
                    padding: EdgeInsets.all(20.0),
                    child: _buildLoginContent(
                      context,
                      scale,
                      maxWidth,
                      needsScroll,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(20.0),
                    child: _buildLoginContent(
                      context,
                      scale,
                      maxWidth,
                      needsScroll,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginContent(
    BuildContext context,
    double scale,
    double maxWidth,
    bool needsScroll,
  ) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: needsScroll ? MainAxisSize.min : MainAxisSize.min,
        children: [
          // Logo - Flexible solo si no hay scroll
          needsScroll
              ? Container(
                  width: 120 * scale,
                  height: 120 * scale,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://raw.githubusercontent.com/FranMejiasGlez/TallerFlutter/main/sandbox_fran/imperativo/img/Logo.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 120 * scale,
                      maxHeight: 120 * scale,
                    ),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://raw.githubusercontent.com/FranMejiasGlez/TallerFlutter/main/sandbox_fran/imperativo/img/Logo.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

          SizedBox(height: 16 * scale),

          // Texto descriptivo
          needsScroll
              ? Text(
                  "Bienvenido a Migaz. ¿Preparado para cocinar?",
                  style: TextStyle(
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              : Flexible(
                  child: Text(
                    "Bienvenido a Migaz. ¿Preparado para cocinar?",
                    style: TextStyle(
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

          SizedBox(height: 12 * scale),

          // Título
          Text(
            "Iniciar Sesión",
            style: TextStyle(fontSize: 26 * scale, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20 * scale),

          // Formulario
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // E-mail
              Text(
                "E-mail",
                style: TextStyle(
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Container(
                color: Colors.grey[300],
                child: TextField(
                  style: TextStyle(fontSize: 14 * scale),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12 * scale,
                      vertical: 10 * scale,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(height: 12 * scale),

              // Contraseña
              Text(
                "Contraseña",
                style: TextStyle(
                  fontSize: 14 * scale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Container(
                color: Colors.grey[300],
                child: TextField(
                  obscureText: true,
                  style: TextStyle(fontSize: 14 * scale),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12 * scale,
                      vertical: 10 * scale,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(height: 20 * scale),

              // Botones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _PantallaLogin(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFEC601),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * scale,
                          vertical: 12 * scale,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        textStyle: TextStyle(
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Log in'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _PantallaRegistro(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFEC601),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20 * scale,
                          vertical: 12 * scale,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        textStyle: TextStyle(
                          fontSize: 14 * scale,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Regístrate'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Pantalla de Registro ---
class _PantallaRegistro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Escalar basado en el ancho
    final scale = screenWidth > 768 ? (screenWidth / 768).clamp(1.0, 1.4) : 1.0;

    final maxWidth = screenWidth > 1200
        ? 700.0
        : (screenWidth > 768 ? 600.0 : 500.0);

    // Determinar si necesitamos scroll (pantallas muy pequeñas)
    final needsScroll = screenHeight <= 700;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color(0xFF25CCAD),
              Color(0xFFFEC601),
              Color(0xFFEA7317),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: needsScroll
                ? SingleChildScrollView(
                    padding: EdgeInsets.all(20.0),
                    child: _buildRegistroContent(
                      context,
                      scale,
                      maxWidth,
                      needsScroll,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(20.0),
                    child: _buildRegistroContent(
                      context,
                      scale,
                      maxWidth,
                      needsScroll,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegistroContent(
    BuildContext context,
    double scale,
    double maxWidth,
    bool needsScroll,
  ) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: needsScroll ? MainAxisSize.min : MainAxisSize.min,
        children: [
          // Logo
          needsScroll
              ? Container(
                  width: 100 * scale,
                  height: 100 * scale,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://raw.githubusercontent.com/FranMejiasGlez/TallerFlutter/main/sandbox_fran/imperativo/img/Logo.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 100 * scale,
                      maxHeight: 100 * scale,
                    ),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://raw.githubusercontent.com/FranMejiasGlez/TallerFlutter/main/sandbox_fran/imperativo/img/Logo.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

          SizedBox(height: 12 * scale),

          // Texto descriptivo
          needsScroll
              ? Text(
                  "Regístrate en Migaz y empieza a cocinar. ¡Es rápido y fácil!",
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                )
              : Flexible(
                  child: Text(
                    "Regístrate en Migaz y empieza a cocinar. ¡Es rápido y fácil!",
                    style: TextStyle(
                      fontSize: 16 * scale,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

          SizedBox(height: 10 * scale),

          // Título
          Text(
            "Regístrate",
            style: TextStyle(fontSize: 24 * scale, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 16 * scale),

          // Formulario
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nombre de usuario
              Text(
                "Nombre de usuario",
                style: TextStyle(
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Container(
                color: Colors.grey[300],
                child: TextField(
                  style: TextStyle(fontSize: 13 * scale),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12 * scale,
                      vertical: 8 * scale,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(height: 8 * scale),

              // E-mail
              Text(
                "E-mail",
                style: TextStyle(
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Container(
                color: Colors.grey[300],
                child: TextField(
                  style: TextStyle(fontSize: 13 * scale),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12 * scale,
                      vertical: 8 * scale,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(height: 8 * scale),

              // Contraseña
              Text(
                "Contraseña",
                style: TextStyle(
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Container(
                color: Colors.grey[300],
                child: TextField(
                  obscureText: true,
                  style: TextStyle(fontSize: 13 * scale),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12 * scale,
                      vertical: 8 * scale,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(height: 8 * scale),

              // Confirmar contraseña
              Text(
                "Confirmar contraseña",
                style: TextStyle(
                  fontSize: 13 * scale,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Container(
                color: Colors.grey[300],
                child: TextField(
                  obscureText: true,
                  style: TextStyle(fontSize: 13 * scale),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12 * scale,
                      vertical: 8 * scale,
                    ),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(height: 16 * scale),

              // Botón
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => _Login()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFEC601),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20 * scale,
                        vertical: 12 * scale,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      textStyle: TextStyle(
                        fontSize: 14 * scale,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text('Registrarse'),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Pantalla Principal App ---
class _PantallaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Pantallarecetas();
  }
}
