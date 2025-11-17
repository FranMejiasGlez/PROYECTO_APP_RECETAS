import 'package:app_recetas/config/routes.dart';
import 'package:app_recetas/widgets/recipe/user_avatar.dart';

import 'package:flutter/material.dart';

import '../widgets/recipe/recipe_filter_dropdown.dart';
import '../widgets/recipe/recipe_search_bar.dart';
import '../widgets/recipe/recipe_card.dart';
import '../widgets/recipe/recipe_carousel.dart';

class PantallaBiblioteca extends StatefulWidget {
  const PantallaBiblioteca({Key? key}) : super(key: key);

  @override
  State<PantallaBiblioteca> createState() => _PantallaBibliotecaState();
}

class _PantallaBibliotecaState extends State<PantallaBiblioteca> {
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
    'fácil',
    'Medio',
    'Difícil',
  ];

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton.icon(
                      onPressed: () {},

                      label: const Text('Guardados'),
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
                        elevation: 3,
                        minimumSize: const Size(80, 36),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton.icon(
                      onPressed: () {},

                      label: const Text('Mis Recetas'),
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
                        elevation: 3,
                        minimumSize: const Size(80, 36),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _searchQuery.isNotEmpty || _filtroSeleccionado != 'Todos'
                    ? _buildSearchResults()
                    : _buildHomeContent(),
              ),
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
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
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
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),

          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tu biblioteca',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),

          UserAvatar(
            imageUrl:
                'https://raw.githubusercontent.com/FranMejiasGlez/TallerFlutter/main/sandbox_fran/imperativo/img/Logo.png',
            onTap: () => Navigator.pushNamed(context, AppRoutes.perfilUser),
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
      child: Padding(
        padding: EdgeInsetsGeometry.all(80),
        child: Column(
          children: [
            RecipeCarousel(
              title: 'Mis Recetas',
              recipes: List.generate(10, (i) => 'Receta $i'),
            ),
            RecipeCarousel(
              title: 'Guardados',
              recipes: List.generate(10, (i) => 'Receta $i'),
            ),
          ],
        ),
      ),
    );
  }
}
