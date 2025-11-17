import 'dart:convert';
import 'dart:js_interop';
import 'package:http/http.dart' as http;
import 'package:app_recetas/model/recipe.dart';

Future<bool> saveRecipeToServer(Recipe recipe) async {
  final uri = Uri.parse(
    'https://localhost:3000/api/recetas',
  ); // usa HTTPS en producción
  final resp = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(recipe.toJSBox),
  );
  if (resp.statusCode == 201) return true;
  throw Exception('Error guardando receta: ${resp.statusCode} ${resp.body}');
}
