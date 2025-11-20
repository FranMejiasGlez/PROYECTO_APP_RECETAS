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

// LISTA 1: IZQUIERDA (Tus seguidores)
// Hemos cambiado a Carlos y Sofia a 'true' para simular que ya los seguías de antes.
List<Map<String, dynamic>> listaIzquierdaSeguidores = [
  {"name": "Pablo", "img": "https://robohash.org/pablo?set=set5", "loSigo": false},
  {"name": "Maria", "img": "https://robohash.org/maria?set=set5", "loSigo": false},
  // ¡OJO! Carlos ya lo seguimos al iniciar
  {"name": "Carlos", "img": "https://robohash.org/carlos?set=set5", "loSigo": true},
  {"name": "Lucia", "img": "https://robohash.org/lucia?set=set5", "loSigo": false},
  {"name": "Andy", "img": "https://robohash.org/andy?set=set5", "loSigo": false},
  // ¡OJO! Sofia ya la seguimos al iniciar
  {"name": "Sofia", "img": "https://robohash.org/sofia?set=set5", "loSigo": true},
];

// LISTA 2: DERECHA (Gente que tú sigues)
// Incluye los Chefs por defecto Y TAMBIÉN a Carlos y Sofia para que coincida al arranque.
List<Map<String, dynamic>> listaDerechaSeguidos = [
  {"name": "Chef Ramsay", "img": "https://robohash.org/ramsay?set=set5", "loSigo": true},
  {"name": "Jamie Oliver", "img": "https://robohash.org/jamie?set=set5", "loSigo": true},
  // Añadimos aquí los que están en true en la izquierda para mantener la coherencia inicial
  {"name": "Carlos", "img": "https://robohash.org/carlos?set=set5", "loSigo": true},
  {"name": "Sofia", "img": "https://robohash.org/sofia?set=set5", "loSigo": true},
];

// Contadores globales
int numSeguidores = 6; 
int numSeguidos = 3; 

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

  // LÓGICA DE SINCRONIZACIÓN (Igual que antes)
  void _toggleSeguirDesdeIzquierda(int index) {
    setState(() {
      var usuarioIzquierda = listaIzquierdaSeguidores[index];
      bool yaLoSigo = usuarioIzquierda["loSigo"];

      if (yaLoSigo) {
        // Dejar de seguir
        usuarioIzquierda["loSigo"] = false;
        listaDerechaSeguidos.removeWhere((u) => u["name"] == usuarioIzquierda["name"]);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Dejaste de seguir a ${usuarioIzquierda["name"]}"), backgroundColor: Colors.redAccent, duration: const Duration(milliseconds: 600)));
      } else {
        // Empezar a seguir
        usuarioIzquierda["loSigo"] = true;
        listaDerechaSeguidos.add({"name": usuarioIzquierda["name"], "img": usuarioIzquierda["img"], "loSigo": true});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("¡Ahora sigues a ${usuarioIzquierda["name"]}!"), backgroundColor: Colors.green, duration: const Duration(milliseconds: 600)));
      }
      numSeguidos = listaDerechaSeguidos.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo Degradado
          Container(decoration: BoxDecoration(gradient: AppTheme.appGradient)),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // --- HEADER (Sin cambios) ---
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

                // --- ZONA DE LISTAS (IZQUIERDA vs DERECHA) ---
                Expanded(
                  child: Row(
                    children: [
                      // 1. COLUMNA IZQUIERDA: TUS SEGUIDORES (Ahora con estilo de tarjeta)
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
                                  // Usamos el NUEVO widget UserCardIzquierdaStyle
                                  return UserCardIzquierdaStyle(
                                    name: user["name"],
                                    imageAsset: user["img"],
                                    isFollowing: user["loSigo"], 
                                    onFollowPressed: () => _toggleSeguirDesdeIzquierda(index),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Línea divisoria
                      Container(width: 1, color: Colors.black12),

                      // 2. COLUMNA DERECHA: GENTE QUE SIGUES (Estilo tarjeta simple)
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
                                  // Tarjeta simple derecha (relicada el estilo)
                                  return Card(
                                    color: Colors.white.withOpacity(0.6),
                                    margin: const EdgeInsets.only(bottom: 10),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                      leading: CircleAvatar(radius: 18, backgroundImage: NetworkImage(user['img'])),
                                      title: Text(user['name'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                                      trailing: const Icon(Icons.check_circle, color: Colors.green, size: 20),
                                    ),
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

// --- NUEVO WIDGET PARA LA IZQUIERDA ---
// Adopta el estilo de "Card" semitransparente y usa ListTile
class UserCardIzquierdaStyle extends StatelessWidget {
  final String name;
  final String imageAsset;
  final bool isFollowing;
  final VoidCallback onFollowPressed;

  const UserCardIzquierdaStyle({
    super.key,
    required this.name,
    required this.imageAsset,
    required this.isFollowing,
    required this.onFollowPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Usamos la misma estructura de Card que en la derecha
    return Card(
      // Color blanquecino semitransparente
      color: Colors.white.withOpacity(0.6),
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        // Avatar a la izquierda
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey[200],
          backgroundImage: NetworkImage(imageAsset),
        ),
        // Nombre en el centro
        title: Text(
          name,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        // Botón a la derecha (trailing)
        trailing: SizedBox(
          width: 110, // Ancho fijo para que el botón quepa bien
          height: 32,
          child: ElevatedButton(
            onPressed: onFollowPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowing ? const Color(0xFFFF6B6B) : Colors.grey[200],
              foregroundColor: isFollowing ? Colors.white : Colors.black,
              elevation: 0, // Sin sombra para que se vea plano sobre la tarjeta
              padding: const EdgeInsets.symmetric(horizontal: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(isFollowing ? Icons.remove : Icons.add, size: 14),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    isFollowing ? "Dejar de seguir" : "Seguir", // Texto más corto para que quepa
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