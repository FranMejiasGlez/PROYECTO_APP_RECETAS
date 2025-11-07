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
                  //!Botón a la izquierda
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
                          child: const Text('Biblioteca'),
                        ),
                      ),
                    ),
                  ),
                  //Nombre de usuario
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Nombre Usuario', //TODO: Usar el nombre de usuario
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //!Icono de foto de perfil
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                            //TODO: Usar imagen de usuario.
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //!Search Bar
          Expanded(
            child: Container(color: const Color.fromARGB(255, 240, 184, 3)),
          ),
          //!Mas valorados
          Expanded(
            child: Container(
              color: Colors.white,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CarouselView(
                    itemExtent: 300,
                    children: List<Widget>.generate(10, (int index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              Colors.primaries[index % Colors.primaries.length],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'Item $index',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
          //!Mas Nuevo
          Expanded(
            child: Container(
              color: Colors.white,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CarouselView(
                    itemExtent: 300,
                    children: List<Widget>.generate(10, (int index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              Colors.primaries[index % Colors.primaries.length],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            'Item $index',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
          //!Boton crear nueva receta
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFEC601),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Crear receta'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
