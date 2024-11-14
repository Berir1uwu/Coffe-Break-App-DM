import 'package:coffebreak_app/RecipeCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FavoritesProvider.dart'; // El provider donde tienes las recetas creadas por el usuario
import 'Recipe_Service.dart'; // El servicio para cargar recetas desde JSON
import 'recipe_detail_screen.dart'; // Pantalla de detalle de las recetas
import 'Recipe.dart'; // La clase Recipe que hemos definido

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late Future<List<Recipe>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = RecipeService.loadRecipes(); // Cargar las recetas desde el JSON
  }

  @override
  Widget build(BuildContext context) {
    final createdRecipes = context.watch<FavoritesProvider>().createdRecipes;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 229, 218), // Color de fondo
      appBar: AppBar(
        title: const Text('Recetas'),
        backgroundColor: const Color(0xFFCD5C5C),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipesFuture, // Obtener las recetas desde el JSON
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final recipes = snapshot.data ?? [];

          return ListView(
            children: [
              // Recetas predeterminadas (de JSON)
              ...recipes.map((recipe) {
                return RecipeCard(
                  title: recipe.name,
                  description: recipe.description,
                  screen: RecipeDetailScreen(recipe: recipe),
                  image: recipe.image,
                );
              }),
              const Divider(), // Separador para diferenciar las recetas creadas por el usuario

              // Recetas creadas por el usuario
              ...createdRecipes.map((recipe) {
                return RecipeCard(
                  title: recipe, // Usamos el nombre de la receta creada por el usuario
                  description: 'Receta personalizada', // Descripción predeterminada o personalizada
                  screen: RecipeDetailScreen(recipe: Recipe(name: recipe, description: 'Personalizada', ingredients: [], instructions: [], image: '')), image: '', // Aquí deberías crear una receta editada
                );
              }),
            ],
          );
        },
      ),
    );
  }
}


