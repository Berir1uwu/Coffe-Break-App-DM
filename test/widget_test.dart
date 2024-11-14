import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class AddRecipesScreen extends StatefulWidget {
  final CameraDescription camera;

  const AddRecipesScreen({super.key, required this.camera});

  @override
  // ignore: library_private_types_in_public_api
  _AddRecipesScreenState createState() => _AddRecipesScreenState();
}

class _AddRecipesScreenState extends State<AddRecipesScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeCamera;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeCamera = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Receta'),
        backgroundColor: const Color(0xFFCD5C5C), // Color terracota
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Toma una foto de tu receta:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<void>(
              future: _initializeCamera,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Container(
                      width: 250, // Tamaño cuadrado de la cámara
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black.withOpacity(0.5)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CameraPreview(_cameraController), // Muestra la cámara
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const SizedBox(height: 20),
            // Campo para agregar el título de la receta
            TextField(
              decoration: InputDecoration(
                labelText: 'Título de la receta',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
            // Campo para agregar una descripción
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Descripción de la receta',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),
            // Botón para tomar foto
            ElevatedButton(
              onPressed: () {
                // Aquí agregarías la lógica para tomar la foto
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Foto tomada')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6F4F31), // Color café
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Tomar Foto', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 20),
            // Botón para agregar receta
            ElevatedButton(
              onPressed: () {
                // Aquí agregarías la lógica para guardar la receta
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Receta agregada')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCD5C5C), // Color terracota
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Agregar Receta', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
