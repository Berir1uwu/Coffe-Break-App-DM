import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final List<String> _favoriteRecipes = [];
  List<String> get favoriteRecipes => _favoriteRecipes;

  final List<String> _createdRecipes = [];
  List<String> get createdRecipes => _createdRecipes;

  void toggleFavorite(String recipeName) {
    if (_favoriteRecipes.contains(recipeName)) {
      _favoriteRecipes.remove(recipeName);
    } else {
      _favoriteRecipes.add(recipeName);
    }
    notifyListeners();
  }

  void addCreatedRecipe(String recipeName) {
    _createdRecipes.add(recipeName);
    notifyListeners();
  }

  void removeCreatedRecipe(String recipeName) {
    _createdRecipes.remove(recipeName);
    notifyListeners();
  }
}
