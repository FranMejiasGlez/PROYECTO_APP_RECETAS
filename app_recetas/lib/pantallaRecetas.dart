import 'package:flutter/material.dart';

class Pantallarecetas extends StatelessWidget {
  const Pantallarecetas({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 250,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(60)),
                  ElevatedButton(
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
                    child: const Text('Biblioteca'),
                  ),
                  Text('Nombre Usuario'), //TODO: REEMPLAZAR POR VARIABLE
                  Icon(Icons.person, size: 100), //TODO: REEMPLAZAR POR VARIABLE
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 500,
              color: const Color.fromARGB(255, 240, 184, 3),
            ),
          ),
          Expanded(child: Container(height: 500, color: Colors.white)),
          Expanded(child: Container(height: 500, color: Colors.red)),
          Expanded(child: Container(height: 500, color: Colors.black)),
        ],
      ),
    );
  }
}
