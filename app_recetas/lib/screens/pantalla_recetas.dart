import 'package:app_recetas/widgets/recipe/user_avatar.dart';
import 'package:app_recetas/widgets/recipe/ventana_crear_receta.dart';
import 'package:flutter/material.dart';

import '../widgets/recipe/recipe_filter_dropdown.dart';
import '../widgets/recipe/recipe_search_bar.dart';
import '../widgets/recipe/recipe_card.dart';
import '../widgets/recipe/recipe_carousel.dart';

class PantallaRecetas extends StatefulWidget {
  const PantallaRecetas({Key? key}) : super(key: key);

  @override
  State<PantallaRecetas> createState() => _PantallaRecetasState();
}

class _PantallaRecetasState extends State<PantallaRecetas> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _filtroSeleccionado = 'Todos';

  final List<String> _categorias = [
    'Todos',
    'Española',
    'Italiana',
    'Japonesa',
    'Mexicana',
  ];

  final List<String> _dificultad = [
    'Todos los niveles',
    'fácil',
    'Medio',
    'Difícil',
  ];
  // Esta lista debería venir de un servicio/provider
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
  void initState() {
    super.initState();
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
            colors: [Color(0xFF25CCAD), Color(0xFFFEC601), Color(0xFFEA7317)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchSection(),
              const SizedBox(height: 16),
              Expanded(
                child: _searchQuery.isNotEmpty || _filtroSeleccionado != 'Todos'
                    ? _buildSearchResults()
                    : _buildHomeContent(),
              ),
              _buildCreateRecipeButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // limitar ancho del botón para que no estire la fila
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFEC601),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text('Biblioteca'),
              ),
            ),
          ),

          // espacio flexible para el título (centrado y recortado si hace falta)
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Nombre Usuario',
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),

          // avatar con tamaño fijo
          UserAvatar(
            imageUrl:
                'https://raw.githubusercontent.com/FranMejiasGlez/TallerFlutter/main/sandbox_fran/imperativo/img/Logo.png',
            onTap: () => print('Avatar clickeado'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          RecipeFilterDropdown(
            value: _filtroSeleccionado,
            categories: _categorias,
            onChanged: (newValue) {
              if (newValue != null) {
                setState(() => _filtroSeleccionado = newValue);
              }
            },
          ),
          const SizedBox(height: 12),
          RecipeSearchBar(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
            onClear: () => setState(() {
              _searchController.clear();
              _searchQuery = '';
            }),
            showClearButton: _searchQuery.isNotEmpty,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_recetasFiltradas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text('No se encontraron recetas'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _recetasFiltradas.length,
      itemBuilder: (context, index) {
        final receta = _recetasFiltradas[index];
        return RecipeCard(
          nombre: receta['nombre'],
          categoria: receta['categoria'],
          valoracion: receta['valoracion'],
          onTap: () => print('Receta: ${receta['nombre']}'),
        );
      },
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          RecipeCarousel(
            title: 'Más valorado',
            recipes: List.generate(10, (i) => 'Receta $i'),
          ),
          RecipeCarousel(
            title: 'Más nuevo',
            recipes: List.generate(10, (i) => 'Receta $i'),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateRecipeButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DialogoCrearReceta(
                categorias: _categorias,
                dificultades: _dificultad,
              ),
            );
          },

          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFEC601),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
          ),
          child: const Text('Crear Receta'),
        ),
      ),
    );
  }
}
