import 'package:flutter/material.dart';

class Pantallarecetas extends StatelessWidget {
  const Pantallarecetas({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,

              child: Row(
                children: [
                  // Botón a la izquierda
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFEC601),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Izquierda'),
                        ),
                      ),
                    ),
                  ),
                  //Nombre de usuario
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('Nombre Usuario'),
                    ),
                  ),
                  //Icono de foto de perfil
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(Icons.person,size: 80,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(color: const Color.fromARGB(255, 240, 184, 3)),
          ),
          Expanded(child: Container(color: Colors.white)),
          Expanded(child: Container(color: Colors.red)),
          Expanded(child: Container(color: Colors.black)),
        ],
      ),
    );
  }
}
