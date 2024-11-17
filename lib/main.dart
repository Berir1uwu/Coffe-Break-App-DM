import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'FavoritesProvider.dart';
import 'ProfileScreen.dart';
import 'RecipesScreen.dart';
import 'AddRecipesScreen.dart';
import 'TuOpinionScreen.dart';

void main() => runApp(const CoffeeBreakApp());

class CoffeeBreakApp extends StatelessWidget {
  const CoffeeBreakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      ],
      child: const MaterialApp(
        title: 'Coffee Break',
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final createdRecipes = context.watch<FavoritesProvider>().createdRecipes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido a Coffee Break'),
        backgroundColor: const Color(0xFFCD5C5C),
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
        color: const Color.fromARGB(255, 238, 229, 218),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Date un break con un exquisito café',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Hazlo tú mismo!! Descubre el delicioso mundo del café.',
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
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: const Color.fromARGB(255, 85, 40, 15),
                ),
                child: const Text('Mi Barista'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Verifica si hay una cámara disponible antes de navegar
                  final cameras = await availableCameras();
                  if (cameras.isNotEmpty) {
                    Navigator.push(
                      // ignore: use_build_context_synchronously
                      context,
                      MaterialPageRoute(builder: (context) => AddRecipeScreen(camera: cameras.first)),
                    );
                  } else {
                    print('No hay cámaras disponibles');
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: const Color.fromARGB(255, 85, 40, 15),
                ),
                child: const Text('Mis recetas'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TuOpinionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: const Color(0xFFCD5C5C),
                ),
                child: const Text('Tu Opinión'),
              ),
              const SizedBox(height: 40),
              const Text(
                'Últimas Recetas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              createdRecipes.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: createdRecipes.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(createdRecipes[index]),
                            leading: const Icon(Icons.local_cafe, color: Color(0xFFCD5C5C)),
                          );
                        },
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Aún no has creado ninguna receta. ¡Crea una para comenzar!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
