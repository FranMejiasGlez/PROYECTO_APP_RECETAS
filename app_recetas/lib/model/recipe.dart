class Recipe {
  final String nombre;
  final String categoria;
  final double valoracion;
  final String descripcion;
  final String dificultad;
  final int servings;
  final List<String> pasos;
  final List<String> ingredientes;
  final String? youtubeUrl;
  final String? imageUrl;

  Recipe({
    required this.nombre,
    required this.categoria,
    this.valoracion = 0.0,
    this.descripcion = '',
    this.dificultad = 'Todos los niveles',
    this.servings = 1,
    List<String>? pasos,
    List<String>? ingredientes,
    this.youtubeUrl,
    this.imageUrl,
  }) : pasos = pasos ?? const [],
        ingredientes = ingredientes ?? const [];

  Map<String, dynamic> toMap() => {
        'nombre': nombre,
        'categoria': categoria,
        'valoracion': valoracion,
        'descripcion': descripcion,
        'dificultad': dificultad,
        'servings': servings,
        'pasos': pasos,
        'ingredientes': ingredientes,
        'youtubeUrl': youtubeUrl,
        'imageUrl': imageUrl,
      };

  @override
  String toString() {
    return 'Recipe(nombre: $nombre, categoria: $categoria, valoracion: $valoracion, servings: $servings, pasos:${pasos.length}, ingredientes:${ingredientes.length}, youtubeUrl:$youtubeUrl, imageUrl:$imageUrl)';
  }

  factory Recipe.fromMap(Map<String, dynamic> m) => Recipe(
        nombre: m['nombre'] as String? ?? '',
        categoria: m['categoria'] as String? ?? 'Otros',
        valoracion: (m['valoracion'] is num)
            ? (m['valoracion'] as num).toDouble()
            : 0.0,
        descripcion: m['descripcion'] as String? ?? '',
        dificultad: m['dificultad'] as String? ?? 'Todos los niveles',
        servings: (m['servings'] is int)
            ? m['servings'] as int
            : (m['servings'] is num ? (m['servings'] as num).toInt() : 1),
        pasos: (m['pasos'] is List) ? List<String>.from(m['pasos']) : const [],
        ingredientes: (m['ingredientes'] is List)
            ? List<String>.from(m['ingredientes'])
            : const [],
        youtubeUrl: m['youtubeUrl'] as String?,
        imageUrl: m['imageUrl'] as String?,
      );
}
