import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(MiAplicacion());

class MiAplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MIGAZ', home: Login());
  }
}

// --- Pantalla Principal Login ---
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Pantalla Principal')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            /* colors: <Color>[
              Color(0xFF25CCAD),
              Color(0xFFFEC601),
              Color(0x1AF7F7F7),
              Color(0xFFEA7317),
              Color(0xFF4F5D75),
            ],*/
            colors: <Color>[
              //  Color(0xFFF7F7F7),
              Color(0xFF25CCAD),
              Color(0xFFFEC601),
              Color(0xFFEA7317),
              //   Color(0xFFF7F7F7),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
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
                  Container(
                    child: Center(
                      child: Text(
                        "Bienvenido a Migaz. Preparado para cocinar?",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
                    child: Center(
                      child: Text(
                        "Iniciar Sesion",
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("E-mail", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    color: Colors.grey,
                    width: 500,
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Contraseña", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 500,
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PantallaLogin(),
                                      ),
                                    );
                                  },
                                  child: const Text('Log in'),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PantallaRegistro(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(
                                      0xFFEA7317,
                                    ), // Color de fondo
                                    foregroundColor:
                                        Colors.white, // Color del texto
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ), // Bordes redondeados
                                    ),
                                    elevation: 5, // Sombra
                                    textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: const Text('Registrate'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Segunda Pantalla ---
class PantallaRegistro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Pantalla Principal')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            /*colors: <Color>[
              Color(0xFF25CCAD),
              Color(0xFFFEC601),
              Color(0x1AF7F7F7),
              Color(0xFFEA7317),
              Color(0xFF4F5D75),
            ],*/
            colors: <Color>[
              //  Color(0xFFF7F7F7),
              Color(0xFF25CCAD),
              Color(0xFFFEC601),
              Color(0xFFEA7317),
              //   Color(0xFFF7F7F7),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
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
                  Container(
                    child: Center(
                      child: Text(
                        "Regístrate en Migaz y empieza a cocinar. ¡Es rápido y fácil!",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 80),
                    child: Center(
                      child: Text("Registrate", style: TextStyle(fontSize: 35)),
                    ),
                  ),
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Nombre de usuario",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  //BOX del TextField de email
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    color: Colors.grey,
                    width: 500,
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("E-mail", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  //BOX del TextField de email
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    color: Colors.grey,
                    width: 500,
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Contraseña", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                  //BOX del TextField de contraseña
                  Container(
                    color: Colors.grey,
                    width: 500,
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Confirmar contraseña",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  //BOX del TextField de email
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    color: Colors.grey,
                    width: 500,
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: const Text('Registrarse'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Pantalla Principal App --
class PantallaLogin extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("log")));
  }
}
