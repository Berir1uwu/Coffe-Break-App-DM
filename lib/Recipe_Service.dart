import 'dart:convert';
import 'package:flutter/services.dart';
import 'Recipe.dart'; // Aquí va la clase Recipe que definimos anteriormente

class RecipeService {
  // Cargar recetas desde el archivo JSON
  static Future<List<Recipe>> loadRecipes() async {
    final String response = await rootBundle.loadString('assets/recipes.json');
    final List<dynamic> data = json.decode(response);

    return data.map((recipeJson) => Recipe.fromJson(recipeJson)).toList();
  }
}
