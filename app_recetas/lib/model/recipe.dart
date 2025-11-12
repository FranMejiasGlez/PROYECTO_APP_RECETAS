import 'dart:convert';

class Recipe {
  final String nombre;
  final String descripcion;
  final List<String> ingredientes;
  final String categoria;
  final String dificultad;
  final List<String> pasos;
  final String urlImagen;
  final String urlYoutube;
  final String tiempoPreparacion;
  final String servings;
  final double valoracion;

  Recipe({
    required this.nombre,
    required this.descripcion,
    this.ingredientes = const [],
    this.categoria = '',
    this.dificultad = '',
    this.pasos = const [],
    this.urlImagen = '',
    this.urlYoutube = '',
    this.tiempoPreparacion = '',
    this.servings = '',
    this.valoracion = 0.0,
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'descripcion': descripcion,
    'ingredientes': ingredientes,
    'categoria': categoria,
    'dificultad': dificultad,
    'pasos': pasos,
    'urlImagen': urlImagen,
    'urlYoutube': urlYoutube,
    'tiempoPreparacion': tiempoPreparacion,
    'servings': servings,
    'valoracion': valoracion,
  };

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    nombre: json['nombre'] ?? '',
    descripcion: json['descripcion'] ?? '',
    ingredientes: List<String>.from(json['ingredientes'] ?? []),
    categoria: json['categoria'] ?? '',
    dificultad: json['dificultad'] ?? '',
    pasos: List<String>.from(json['pasos'] ?? []),
    urlImagen: json['urlImagen'] ?? '',
    urlYoutube: json['urlYoutube'] ?? '',
    tiempoPreparacion: json['tiempoPreparacion'] ?? '',
    servings: json['servings'] ?? '',
    valoracion: (json['valoracion'] ?? 0).toDouble(),
  );

  @override
  String toString() => jsonEncode(toJson());
}
