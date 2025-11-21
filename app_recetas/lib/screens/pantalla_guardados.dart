import 'package:app_recetas/config/routes.dart';
import 'package:app_recetas/model/recipe.dart';
import 'package:app_recetas/widgets/recipe/user_avatar.dart';
import 'package:app_recetas/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:app_recetas/widgets/recipe/recipe_card.dart';
import '../widgets/recipe/recipe_filter_dropdown.dart';
import '../widgets/recipe/recipe_search_bar.dart';

class PantallaGuardados extends StatefulWidget {
  const PantallaGuardados({Key? key}) : super(key: key);

  @override
  State<PantallaGuardados> createState() => _PantallaGuardadosState();
}

class _PantallaGuardadosState extends State<PantallaGuardados> {
  bool _dialogoAbiertoGuardados = false;
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

  final List<Recipe> _recetasGuardadas = [
    Recipe(
      nombre: 'Paella Valenciana',
      categoria: 'Española',
      descripcion: 'Deliciosa paella tradicional valenciana',
      dificultad: 'Medio',
      tiempo: '45 min',
      servings: 4,
      pasos: ['Paso 1', 'Paso 2', 'Paso 3'],
      ingredientes: ['Arroz', 'Azafrán', 'Pollo'],
    ),
    Recipe(
      nombre: 'Tortilla de Patatas',
      categoria: 'Española',
      descripcion: 'Tortilla española clásica',
      dificultad: 'Fácil',
      tiempo: '20 min',
      servings: 3,
      pasos: ['Paso 1', 'Paso 2'],
      ingredientes: ['Patatas', 'Huevos', 'Cebolla'],
    ),
    Recipe(
      nombre: 'Pizza Margarita',
      categoria: 'Italiana',
      descripcion: 'Pizza italiana auténtica',
      dificultad: 'Medio',
      tiempo: '30 min',
      servings: 2,
      pasos: ['Paso 1', 'Paso 2', 'Paso 3'],
      ingredientes: ['Harina', 'Tomate', 'Mozzarella'],
    ),
    Recipe(
      nombre: 'Sushi Roll',
      categoria: 'Japonesa',
      descripcion: 'Sushi roll casero',
      dificultad: 'Difícil',
      tiempo: '40 min',
      servings: 2,
      pasos: ['Paso 1', 'Paso 2', 'Paso 3', 'Paso 4'],
      ingredientes: ['Arroz', 'Nori', 'Pepino', 'Aguacate'],
    ),
    Recipe(
      nombre: 'Tacos al Pastor',
      categoria: 'Mexicana',
      descripcion: 'Tacos mexicanos tradicionales',
      dificultad: 'Medio',
      tiempo: '35 min',
      servings: 4,
      pasos: ['Paso 1', 'Paso 2', 'Paso 3'],
      ingredientes: ['Carne', 'Tortillas', 'Cebolla'],
    ),
    Recipe(
      nombre: 'Lasaña Boloñesa',
      categoria: 'Italiana',
      descripcion: 'Lasaña casera con salsa boloñesa',
      dificultad: 'Medio',
      tiempo: '50 min',
      servings: 6,
      pasos: ['Paso 1', 'Paso 2', 'Paso 3', 'Paso 4'],
      ingredientes: ['Pasta', 'Carne molida', 'Tomate', 'Queso'],
    ),
  ];

  List<Recipe> get _recetasFiltradas {
    return _recetasGuardadas.where((receta) {
      final matchesSearch = receta.nombre.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesFilter =
          _filtroSeleccionado == 'Todos' ||
          receta.categoria == _filtroSeleccionado;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _mostrarDetallesReceta(Recipe receta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (receta.imageUrl != null && receta.imageUrl!.isNotEmpty)
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 250,
                          height: 200,
                          child: Image.network(
                            "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480_1_5x/img/recipe/ras/Assets/4ADF5D92-29D0-4EB7-8C8B-5C7DAA0DA74A/Derivates/E5E1004A-1FF0-448B-87AF-31393870B653.jpg",
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 250,
                      height: 200,
                      child: Image.network(
                        "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480_1_5x/img/recipe/ras/Assets/4ADF5D92-29D0-4EB7-8C8B-5C7DAA0DA74A/Derivates/E5E1004A-1FF0-448B-87AF-31393870B653.jpg",
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    receta.nombre,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (receta.descripcion.isNotEmpty)
                    Text(
                      receta.descripcion,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _infoItem(
                              icon: Icons.schedule,
                              label: 'Tiempo',
                              valor: receta.tiempo,
                            ),
                            _infoItem(
                              icon: Icons.star,
                              label: 'Dificultad',
                              valor: receta.dificultad,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _infoItem(
                              icon: Icons.people,
                              label: 'Servings',
                              valor: '${receta.servings}',
                            ),
                            _infoItem(
                              icon: Icons.restaurant,
                              label: 'Categoría',
                              valor: receta.categoria,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (receta.ingredientes.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Ingredientes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: receta.ingredientes
                          .map(
                            (ingrediente) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.circle,
                                    size: 6,
                                    color: Colors.teal,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(ingrediente)),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  if (receta.pasos.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Pasos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        receta.pasos.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(receta.pasos[index])),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Cerrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String label,
    required String valor,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.teal),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            valor,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    // CASO 1: Nueva lógica (Viene un nombre para abrir)
    if (args is String && !_dialogoAbiertoGuardados) {
      // Buscamos la receta por nombre en tu lista local _recetasGuardadas
      try {
        final recetaAbrevar = _recetasGuardadas.firstWhere(
          (r) => r.nombre == args,
        );
        _dialogoAbiertoGuardados = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _mostrarDetallesReceta(recetaAbrevar);
        });
      } catch (e) {
        // Si no se encuentra por nombre, no hacemos nada (solo se muestra la lista)
      }
    }
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
        decoration: BoxDecoration(gradient: AppTheme.appGradient),
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
              'Recetas Guardadas',
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
            const Text('No se encontraron recetas'),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final cardWidth = (screenWidth - 36) / 2;
        final cardHeight = cardWidth * 1.2;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: cardWidth / cardHeight,
            ),
            itemCount: _recetasFiltradas.length,
            itemBuilder: (context, index) {
              final receta = _recetasFiltradas[index];
              return RecipeCard(
                nombre: receta.nombre,
                categoria: receta.categoria,
                valoracion: 4.5,
                onTap: () => _mostrarDetallesReceta(receta),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildHomeContent() {
    if (_recetasGuardadas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay recetas guardadas',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final cardWidth =
            (screenWidth - 36) / 2; // 36 = padding(12*2) + spacing(12)
        final cardHeight = cardWidth * 1.2; // Proporción 1:1.2 para tarjetas

        return Padding(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: cardWidth / cardHeight,
            ),
            itemCount: _recetasGuardadas.length,
            itemBuilder: (context, index) {
              final receta = _recetasGuardadas[index];
              return RecipeCard(
                nombre: receta.nombre,
                categoria: receta.categoria,
                valoracion: 4.5,
                onTap: () => _mostrarDetallesReceta(receta),
              );
            },
          ),
        );
      },
    );
  }
}
