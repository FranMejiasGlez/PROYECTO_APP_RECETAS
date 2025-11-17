/*import 'package:flutter/material.dart';

class PantallaPerfilUser extends StatefulWidget {
  const PantallaPerfilUser({super.key});

  @override
  State<PantallaPerfilUser> createState() => _PantallaPerfilUserState();
}

class _PantallaPerfilUserState extends State<PantallaPerfilUser> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}*/
import 'package:app_recetas/config/routes.dart';
import 'package:flutter/material.dart';



class PantallaPerfilUser extends StatefulWidget {
  const PantallaPerfilUser({super.key});

  @override
  State<PantallaPerfilUser> createState() => _PantallaPerfilUserState();
}

class _PantallaPerfilUserState extends State<PantallaPerfilUser> {
  
  // 1. VARIABLES DE ESTADO (Datos que cambian)
  int numSeguidores = 0; // Ejemplo inicial
  int numSeguidos = 0;    // Ejemplo inicial

  // Esta es tu "Base de datos" local de usuarios sugeridos (Te siguen, tú no a ellos)
  final List<Map<String, String>> _usuariosSugeridos = [
    {"name": "Pablo", "img": "https://robohash.org/pablo?set=set5"},
    {"name": "Maria", "img": "https://robohash.org/maria?set=set5"},
    {"name": "Carlos", "img": "https://robohash.org/carlos?set=set5"},
    {"name": "Lucia", "img": "https://robohash.org/lucia?set=set5"},
    {"name": "Andy", "img": "https://robohash.org/andy?set=set5"},
    {"name": "Sofia", "img": "https://robohash.org/sofia?set=set5"},
  ];

  // 2. LÓGICA: Función para seguir a un usuario
  void _seguirUsuario(int index) {
    setState(() {
      // Aumentamos tus seguidos
      numSeguidos++; 
      // Quitamos al usuario de esta lista (desaparece y "sube" el siguiente)
      _usuariosSugeridos.removeAt(index);
    });
    
    // Feedback visual (opcional)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("¡Ahora sigues a este usuario!"), 
        duration: Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack para el fondo degradado
      body: Stack(
        children: [
          // Fondo Degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF53F436), 
                  Color(0xFFF2F436), 
                  Color(0xFFFFB600), 
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                
                // --- HEADER (Navegación y Perfil) ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Botón Atrás
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 30, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                      
                      // 2. Botones Centrales
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0), // Ajuste visual a la derecha
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFB68E),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                "Tu Perfil",
                                style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // Botón Biblioteca con Navegación
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.biblioteca,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1CC4A8),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Text(
                                  "Biblioteca",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // 3. Ajustes y Perfil (Alineación corregida)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Botón Ajustes con Navegación
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, right: 10.0),
                            child: GestureDetector(
                              onTap: (){
                                 Text("Ir a Ajustes");//Enlace a pantalla ajustes
                              },
                              child: const Icon(Icons.settings_outlined, size: 30, color: Colors.black)
                            ),
                          ),

                          // Foto y Nombre
                          Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1CC4A8),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.person_outline, size: 40, color: Colors.purple),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Nombre\nUsuario",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 40),

                // --- LISTAS DINÁMICAS ---
                Expanded(
                  child: Row(
                    children: [
                      // COLUMNA IZQUIERDA: SEGUIDORES (Lista interactiva)
                      Expanded(
                        child: Column(
                          children: [
                            // Contador Dinámico
                            Text(
                              "$numSeguidores Seguidores",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                            ),
                            const SizedBox(height: 20),
                            
                            // Lista Generada Automáticamente
                            Expanded(
                              child: _usuariosSugeridos.isEmpty 
                              ? const Center(child: Text("¡Estás al día!"))
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  itemCount: _usuariosSugeridos.length,
                                  itemBuilder: (context, index) {
                                    final user = _usuariosSugeridos[index];
                                    return UserCard(
                                      name: user["name"]!,
                                      imageAsset: user["img"]!,
                                      // Pasamos la función para que el botón sepa qué hacer
                                      onFollowPressed: () => _seguirUsuario(index),
                                    );
                                  },
                                ),
                            ),
                          ],
                        ),
                      ),
                      
                      // COLUMNA DERECHA: SEGUIDOS (Solo contador dinámico por ahora)
                      Expanded(
                        child: Column(
                          children: [
                            // Contador Dinámico (cambia cuando sigues a alguien)
                            Text(
                              "$numSeguidos Seguidos",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
                            ),
                            const SizedBox(height: 20),
                            // Aquí podrías poner otra lista o dejarlo estático
                            const Expanded(
                              child: Center(child: Text("Lista de seguidos...")),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET USER CARD MODIFICADO PARA RECIBIR ACCIÓN ---
class UserCard extends StatelessWidget {
  final String name;
  final String imageAsset;
  final VoidCallback onFollowPressed; // Nueva variable: La acción a ejecutar

  const UserCard({
    super.key,
    required this.name,
    required this.imageAsset,
    required this.onFollowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                backgroundImage: NetworkImage(imageAsset),
              ),
              const SizedBox(height: 5),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: onFollowPressed, // Ejecutamos la función que viene del padre
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(0, 30),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, size: 16),
                    SizedBox(width: 2),
                    Flexible(
                      child: Text(
                        "Seguir también",
                        style: TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}