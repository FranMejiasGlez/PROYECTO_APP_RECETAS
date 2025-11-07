import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class Pantallarecetas extends StatefulWidget {
  const Pantallarecetas({Key? key}) : super(key: key);

  @override
  State<Pantallarecetas> createState() => _PantallarecetasState();
}

class _PantallarecetasState extends State<Pantallarecetas> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _filtroSeleccionado = 'Todos';
  //!Esto seran objetos JSON
  // Lista de ejemplo de recetas
  final List<Map<String, dynamic>> _todasLasRecetas = [
    {'nombre': 'Paella Valenciana', 'categoria': 'Española', 'valoracion': 4.8},
    {
      'nombre': 'Tortilla de Patatas',
      'categoria': 'Española',
      'valoracion': 4.5,
    },
    {'nombre': 'Pizza Margarita', 'categoria': 'Italiana', 'valoracion': 4.7},
    {'nombre': 'Sushi Roll', 'categoria': 'Japonesa', 'valoracion': 4.9},
    {'nombre': 'Tacos al Pastor', 'categoria': 'Mexicana', 'valoracion': 4.6},
    {'nombre': 'Lasaña Boloñesa', 'categoria': 'Italiana', 'valoracion': 4.4},
    {'nombre': 'Ramen', 'categoria': 'Japonesa', 'valoracion': 4.8},
    {'nombre': 'Gazpacho', 'categoria': 'Española', 'valoracion': 4.3},
  ];

  List<Map<String, dynamic>> get _recetasFiltradas {
    return _todasLasRecetas.where((receta) {
      final matchesSearch = receta['nombre'].toString().toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );

      final matchesFilter =
          _filtroSeleccionado == 'Todos' ||
          receta['categoria'] == _filtroSeleccionado;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
          child: Column(
            children: [
              // Header con foto de usuario
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFEC601),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: const Text('Biblioteca'),
                    ),
                    const Text(
                      'Nombre Usuario',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Avatar clickeado');
                        // Navegar a perfil o mostrar menú
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://raw.githubusercontent.com/FranMejiasGlez/TallerFlutter/main/sandbox_fran/imperativo/img/Logo.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Filtros y SearchBar con ancho fijo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Dropdown de categorías con ancho fijo
                    SizedBox(
                      width: 200,
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButton<String>(
                          value: _filtroSeleccionado,
                          isExpanded: true,
                          underline: const SizedBox(),
                          icon: const Icon(Icons.arrow_drop_down, size: 20),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Todos',
                              child: Text('Todas las categorías'),
                            ),
                            DropdownMenuItem(
                              value: 'Española',
                              child: Text('Española'),
                            ),
                            DropdownMenuItem(
                              value: 'Italiana',
                              child: Text('Italiana'),
                            ),
                            DropdownMenuItem(
                              value: 'Japonesa',
                              child: Text('Japonesa'),
                            ),
                            DropdownMenuItem(
                              value: 'Mexicana',
                              child: Text('Mexicana'),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _filtroSeleccionado = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Barra de búsqueda con ancho fijo
                    SizedBox(
                      width: 600,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Buscar recetas...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchQuery.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        _searchController.clear();
                                        _searchQuery = '';
                                      });
                                    },
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Resultados de búsqueda o contenido original
              Expanded(
                child: _searchQuery.isNotEmpty || _filtroSeleccionado != 'Todos'
                    ? _buildResultadosBusqueda()
                    : _buildContenidoOriginal(),
              ),

              // Botón crear receta
              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFEC601),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text('Crear Receta'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultadosBusqueda() {
    if (_recetasFiltradas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              'No se encontraron recetas',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _recetasFiltradas.length,
      itemBuilder: (context, index) {
        final receta = _recetasFiltradas[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.restaurant, size: 32),
            ),
            title: Text(
              receta['nombre'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(receta['categoria']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                Text(
                  receta['valoracion'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            onTap: () {
              print('Receta seleccionada: ${receta['nombre']}');
            },
          ),
        );
      },
    );
  }

  Widget _buildContenidoOriginal() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Más valorado
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Más valorado',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 400,
            width: MediaQuery.sizeOf(context).width / 1.6,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
                scrollbars: false,
              ),
              child: CarouselView(
                itemExtent: MediaQuery.sizeOf(context).width,
                children: List.generate(10, (int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Receta $index',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // Más nuevo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Más nuevo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 400,
            width: MediaQuery.sizeOf(context).width / 1.6,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
                scrollbars: false,
              ),
              child: CarouselView(
                itemExtent: MediaQuery.sizeOf(context).width,
                children: List.generate(10, (int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Receta $index',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
