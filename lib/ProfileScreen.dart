import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Importamos image_picker
import 'package:permission_handler/permission_handler.dart'; // Importamos permission_handler

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = 'Juan Pérez';
  String _email = 'juan.perez@example.com';
  String _bio = 'Aficionado al café que disfruta explorar nuevas recetas y técnicas de preparación.';
  File? _profileImage;

  final _picker = ImagePicker();

  // Método para solicitar permisos automáticamente
  Future<void> _requestPermission() async {
    // Verificamos si el permiso para acceder a fotos está concedido
    final status = await Permission.photos.request();
    if (status.isGranted) {
      print('Permiso concedido');
    } else {
      print('Permiso denegado');
      // Aquí puedes manejar lo que ocurre si el usuario deniega el permiso, 
      // como mostrar un mensaje o dirigirlo a la configuración.
    }
  }

  // Método para elegir una imagen
  Future<void> _pickImage() async {
    // Solicitamos permisos antes de abrir la galería
    await _requestPermission();
    if (await Permission.photos.isGranted) {
      // Si el permiso fue concedido, abre la galería para seleccionar una imagen
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    }
  }

  // Método para guardar los cambios (aunque por ahora solo se muestra un print)
  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Aquí puedes guardar los datos editados
      print('Datos guardados:');
      print('Nombre: $_name');
      print('Email: $_email');
      print('Biografía: $_bio');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Foto de perfil
                Center(
                  child: GestureDetector(
                    onTap: _pickImage, // Llama a _pickImage al tocar la imagen
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.camera_alt, size: 30, color: Colors.white)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Campo de nombre
                const Text('Nombre', style: TextStyle(fontSize: 18)),
                TextFormField(
                  initialValue: _name,
                  onSaved: (value) => _name = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo de email
                const Text('Email', style: TextStyle(fontSize: 18)),
                TextFormField(
                  initialValue: _email,
                  onSaved: (value) => _email = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El email es obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Campo de biografía
                const Text('Biografía', style: TextStyle(fontSize: 18)),
                TextFormField(
                  initialValue: _bio,
                  onSaved: (value) => _bio = value ?? '',
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La biografía es obligatoria';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Botón para guardar los cambios
                ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCD5C5C)),
                  child: const Text('Guardar Cambios', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
