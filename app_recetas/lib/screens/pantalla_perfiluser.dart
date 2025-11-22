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
import 'package:app_recetas/utils/app_theme.dart';
import 'package:app_recetas/widgets/recipe/user_avatar.dart';

// ---------------------------------------------------------------------------
// ✅ ZONA GLOBAL: DATOS INICIALES
// ---------------------------------------------------------------------------

List<Map<String, dynamic>> listaIzquierdaSeguidores = [
  {"name": "Pablo", "img": "https://robohash.org/pablo?set=set5", "loSigo": false},
  {"name": "Maria", "img": "https://robohash.org/maria?set=set5", "loSigo": false},
  {"name": "Carlos", "img": "https://robohash.org/carlos?set=set5", "loSigo": true},
  {"name": "Lucia", "img": "https://robohash.org/lucia?set=set5", "loSigo": false},
  {"name": "Andy", "img": "https://robohash.org/andy?set=set5", "loSigo": false},
  {"name": "Sofia", "img": "https://robohash.org/sofia?set=set5", "loSigo": true},
];

List<Map<String, dynamic>> listaDerechaSeguidos = [
  {"name": "Chef Ramsay", "img": "https://robohash.org/ramsay?set=set5", "loSigo": true},
  {"name": "Jamie Oliver", "img": "https://robohash.org/jamie?set=set5", "loSigo": true},
  {"name": "Carlos", "img": "https://robohash.org/carlos?set=set5", "loSigo": true},
  {"name": "Sofia", "img": "https://robohash.org/sofia?set=set5", "loSigo": true},
];

int numSeguidores = 6; 
int numSeguidos = 0; 

// ---------------------------------------------------------------------------

class PantallaPerfilUser extends StatefulWidget {
  const PantallaPerfilUser({super.key});

  @override
  State<PantallaPerfilUser> createState() => _PantallaPerfilUserState();
}

class _PantallaPerfilUserState extends State<PantallaPerfilUser> {

  @override
  void initState() {
    super.initState();
    numSeguidos = listaDerechaSeguidos.length;
  }

  // LÓGICA 1: ACCIÓN DESDE LA IZQUIERDA (Solo permite Seguir)
  void _seguirDesdeIzquierda(int index) {
    setState(() {
      var usuarioIzquierda = listaIzquierdaSeguidores[index];
      
      // Si ya lo sigo, no hacemos nada (o podríamos mostrar un mensaje)
      if (usuarioIzquierda["loSigo"] == true) return;

      // Empezar a seguir
      usuarioIzquierda["loSigo"] = true;
      listaDerechaSeguidos.add({"name": usuarioIzquierda["name"], "img": usuarioIzquierda["img"], "loSigo": true});
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("¡Ahora sigues a ${usuarioIzquierda["name"]}!"), backgroundColor: Colors.green, duration: const Duration(milliseconds: 600)));
      
      numSeguidos = listaDerechaSeguidos.length;
    });
  }

  // LÓGICA 2: ACCIÓN DESDE LA DERECHA (Solo Dejar de Seguir)
  void _dejarDeSeguirDesdeDerecha(int index) {
    setState(() {
      var usuarioABorrar = listaDerechaSeguidos[index];
      
      // Sincronizamos con la izquierda para reactivar el botón de seguir
      var coincidenciaEnIzquierda = listaIzquierdaSeguidores.indexWhere((u) => u["name"] == usuarioABorrar["name"]);
      if (coincidenciaEnIzquierda != -1) {
        listaIzquierdaSeguidores[coincidenciaEnIzquierda]["loSigo"] = false;
      }

      // Borramos de la derecha
      listaDerechaSeguidos.removeAt(index);
      numSeguidos = listaDerechaSeguidos.length;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Dejaste de seguir a ${usuarioABorrar["name"]}"), backgroundColor: Colors.redAccent, duration: const Duration(milliseconds: 600)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(gradient: AppTheme.appGradient)),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // HEADER
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 140),
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFEC601), foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 5),
                          child: const FittedBox(fit: BoxFit.scaleDown, child: Icon(Icons.arrow_back)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Column(
                          children: [
                            Container(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12), child: const Text('Tu Perfil', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () => Navigator.pushNamed(context, AppRoutes.biblioteca),
                              label: const Text('Biblioteca'),
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFEC601), foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 3, minimumSize: const Size(80, 36)),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: const EdgeInsets.only(top: 30.0, right: 20.0), child: GestureDetector(onTap: () {}, child: const Icon(Icons.settings_outlined, size: 50, color: Colors.black))),
                          Column(
                            children: [
                              UserAvatar(imageUrl: 'https://raw.githubusercontent.com/FranMejiasGlez/TallerFlutter/main/sandbox_fran/imperativo/img/Logo.png', onTap: () {}),
                              const SizedBox(height: 5),
                              const Text("Nombre\nUsuario", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // ZONA DE LISTAS
                Expanded(
                  child: Row(
                    children: [
                      // 1. COLUMNA IZQUIERDA: SEGUIDORES (Botón Seguir o Estado Siguiendo)
                      Expanded(
                        child: Column(
                          children: [
                            Text("$numSeguidores Seguidores", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                itemCount: listaIzquierdaSeguidores.length,
                                itemBuilder: (context, index) {
                                  final user = listaIzquierdaSeguidores[index];
                                  // Sincronización visual
                                  bool estaEnDerecha = listaDerechaSeguidos.any((u) => u['name'] == user['name']);
                                  
                                  return UserCardIzquierdaStyle(
                                    name: user["name"],
                                    imageAsset: user["img"],
                                    isFollowing: estaEnDerecha, 
                                    modoDerecha: false, // ESTAMOS EN LA IZQUIERDA
                                    onPressed: () => _seguirDesdeIzquierda(index),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(width: 1, color: Colors.black12),

                      // 2. COLUMNA DERECHA: SEGUIDOS (Botón Dejar de seguir)
                      Expanded(
                        child: Column(
                          children: [
                            Text("$numSeguidos Seguidos", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black)),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                itemCount: listaDerechaSeguidos.length,
                                itemBuilder: (context, index) {
                                  final user = listaDerechaSeguidos[index];
                                  
                                  return UserCardIzquierdaStyle(
                                    name: user["name"],
                                    imageAsset: user["img"],
                                    isFollowing: true, 
                                    modoDerecha: true, // ESTAMOS EN LA DERECHA
                                    onPressed: () => _dejarDeSeguirDesdeDerecha(index),
                                  );
                                },
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
          ),
        ],
      ),
    );
  }
}

// --- WIDGET TARJETA DE USUARIO INTELIGENTE ---
class UserCardIzquierdaStyle extends StatelessWidget {
  final String name;
  final String imageAsset;
  final bool isFollowing; // ¿Lo sigo?
  final bool modoDerecha; // ¿Estoy en la lista derecha (para borrar) o izquierda (para añadir)?
  final VoidCallback onPressed;

  const UserCardIzquierdaStyle({
    super.key,
    required this.name,
    required this.imageAsset,
    required this.isFollowing,
    required this.modoDerecha,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    
    // CONFIGURACIÓN DEL BOTÓN SEGÚN COLUMNA
    String textoBoton = "";
    Color colorFondo = Colors.grey[200]!;
    Color colorTexto = Colors.black;
    IconData icono = Icons.add;
    VoidCallback? accionBoton = onPressed;

    if (modoDerecha) {
      // --- MODO DERECHA: Siempre es "Dejar" (Rojo) ---
      textoBoton = "Dejar de seguir";
      colorFondo = const Color(0xFFFF6B6B);
      colorTexto = Colors.white;
      icono = Icons.remove;
    } else {
      // --- MODO IZQUIERDA: Depende del estado ---
      if (isFollowing) {
        // Ya lo sigo: Muestro estado "Siguiendo" (Verde, sin acción de borrar)
        textoBoton = "Siguiendo";
        colorFondo = const Color(0xFF1CC4A8).withOpacity(0.2); // Verde suave
        colorTexto = const Color(0xFF0E6B5C); // Verde oscuro
        icono = Icons.check;
        accionBoton = null; // DESHABILITADO: No se puede borrar desde la izquierda
      } else {
        // No lo sigo: Botón "Seguir" (Gris/Amarillo)
        textoBoton = "Seguir";
        colorFondo = Colors.grey[200]!;
        colorTexto = Colors.black;
        icono = Icons.add;
      }
    }

    return Card(
      color: Colors.white.withOpacity(0.6),
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[200],
          backgroundImage: NetworkImage(imageAsset),
        ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: SizedBox(
          width: 110,
          height: 32,
          child: ElevatedButton(
            onPressed: accionBoton, // Si es null, el botón se ve "desactivado" visualmente
            style: ElevatedButton.styleFrom(
              backgroundColor: colorFondo,
              disabledBackgroundColor: colorFondo, // Para que mantenga color si está desactivado
              disabledForegroundColor: colorTexto,
              foregroundColor: colorTexto,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icono, size: 14),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    textoBoton,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}