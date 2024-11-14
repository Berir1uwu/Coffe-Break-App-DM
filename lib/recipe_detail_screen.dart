import 'package:flutter/material.dart';
import 'Recipe.dart'; // La clase Recipe

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: const Color(0xFFCD5C5C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(recipe.image),
            const SizedBox(height: 20),
            Text(
              recipe.description,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ingredientes:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            for (var ingredient in recipe.ingredients)
              Text(ingredient),
            const SizedBox(height: 20),
            const Text(
              'Instrucciones:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            for (var instruction in recipe.instructions)
              Text(instruction),
          ],
        ),
      ),
    );
  }
}
