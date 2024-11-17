import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // Importar el paquete share_plus
import 'Recipe.dart'; // La clase Recipe

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  // Método para compartir la receta con un selector de aplicaciones
  void _shareRecipe(BuildContext context) {
    final String content = '''
    ¡Mira esta receta que encontré en Coffee Break! ☕️

    *Nombre de la receta:* ${recipe.name}

    *Descripción:* ${recipe.description}

    *Ingredientes:*
    ${recipe.ingredients.map((ingredient) => '- $ingredient').join('\n')}

    *Instrucciones:*
    ${recipe.instructions.map((instruction) => '- $instruction').join('\n')}
    ''';

    // Llama al método share para abrir el selector de aplicaciones
    Share.share(content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: const Color(0xFFCD5C5C),
        actions: [
          // Botón de compartir en la app bar
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareRecipe(context), // Acción al presionar el botón
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(recipe.image), // Asumiendo que la receta tiene una imagen en los assets
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
