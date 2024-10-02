import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Asegúrate de importar la pantalla de presentación

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Coffe Break',
      home: SplashScreen(), // La pantalla inicial es SplashScreen
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffe Break'), // Título actualizado
        backgroundColor: Colors.brown[300], // Color de fondo de la AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.brown[50], // Fondo claro de café
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¡Bienvenido a Coffe Break!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Explora recetas de café y descubre nuevas preparaciones.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RecipesScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.brown,
                ),
                child: const Text('Ver Recetas'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.brown,
                ),
                child: const Text('Ver Favoritos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla de recetas
class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recetas')),
      body: ListView(
        children: [
          const RecipeCard(title: 'Espresso', description: 'Un café fuerte y concentrado.'),
          const RecipeCard(title: 'Cappuccino', description: 'Café con leche y espuma de leche.'),
          const RecipeCard(title: 'Latte', description: 'Café suave con mucha leche.'),
          const RecipeCard(title: 'Cold Brew', description: 'Café preparado con agua fría.'),
        ],
      ),
    );
  }
}

// Tarjeta de receta
class RecipeCard extends StatelessWidget {
  final String title;
  final String description;

  const RecipeCard({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipeId: title)),
          );
        },
      ),
    );
  }
}

// Detalles de la receta
class RecipeDetailScreen extends StatelessWidget {
  final String recipeId;  // ID de la receta a mostrar

  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles de $recipeId')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Detalles de la receta: $recipeId',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Aquí puedes agregar más detalles sobre la receta
            const Text('Instrucciones y lista de ingredientes.'),
          ],
        ),
      ),
    );
  }
}

// Pantalla de favoritos
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: ListView(
        children: const [
          ListTile(title: Text('Receta Favorita 1')),
          ListTile(title: Text('Receta Favorita 2')),
          ListTile(title: Text('Receta Favorita 3')),
        ],
      ),
    );
  }
}

// Pantalla de perfil
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información del Usuario',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Nombre: Juan Pérez', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Email: juan.perez@example.com', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
              'Biografía:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Aficionado al café que disfruta explorar nuevas recetas y técnicas de preparación.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
