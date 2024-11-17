import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'Recipe.dart';  // Asegúrate de importar la clase Recipe
import 'DatabaseHelper.dart';  // Asegúrate de importar tu clase DatabaseHelper

class AddRecipeScreen extends StatefulWidget {
  final CameraDescription camera;

  const AddRecipeScreen({super.key, required this.camera});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeCamera;
  String _imagePath = '';
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  final List<String> _ingredients = [];
  final List<String> _instructions = [];

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

  void _takePicture() async {
    final image = await _cameraController.takePicture();
    setState(() {
      _imagePath = image.path;
    });
  }

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Convertir las listas de ingredientes e instrucciones en cadenas separadas por comas
      final newRecipe = Recipe(
        name: _name,
        description: _description,
        ingredients: _ingredients,
        instructions: _instructions,
        image: _imagePath,
      );

      // Guardar la receta en la base de datos
      int id = await DatabaseHelper.instance.insertRecipe(newRecipe);
      
      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
        content: Text('Receta guardada con ID: $id'),
      ));

      // Limpiar los campos después de guardar
      setState(() {
        _name = '';
        _description = '';
        _ingredients.clear();
        _instructions.clear();
        _imagePath = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Receta'),
        backgroundColor: const Color(0xFFCD5C5C),
      ),
      body: FutureBuilder<void>(
        future: _initializeCamera,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nombre de la receta', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      initialValue: _name,
                      decoration: const InputDecoration(hintText: 'Ejemplo: Espresso'),
                      onSaved: (value) => _name = value ?? '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El nombre es obligatorio';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Descripción', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      initialValue: _description,
                      decoration: const InputDecoration(hintText: 'Escribe una descripción'),
                      onSaved: (value) => _description = value ?? '',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'La descripción es obligatoria';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Ingredientes', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Escribe un ingrediente'),
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          _ingredients.add(value);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text('Instrucciones', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Escribe una instrucción'),
                      onSaved: (value) {
                        if (value != null && value.isNotEmpty) {
                          _instructions.add(value);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    _imagePath.isEmpty
                        ? ElevatedButton(
                            onPressed: _takePicture,
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6B4226)),
                            child: const Text('Tomar Foto', style: TextStyle(color: Colors.white)),
                          )
                        : Image.file(File(_imagePath)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _saveRecipe,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCD5C5C)),
                      child: const Text('Agregar Receta', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
