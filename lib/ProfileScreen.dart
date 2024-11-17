import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:permission_handler/permission_handler.dart'; 
import 'package:flutter_email_sender/flutter_email_sender.dart'; 

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
    final status = await Permission.photos.request();
    if (!status.isGranted) {
      print('Permiso denegado');
    }
  }

  
  Future<void> _pickImage() async {
    await _requestPermission();
    if (await Permission.photos.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    }
  }

  // Método para enviar un correo notificando la actualización de perfil
  Future<void> _sendEmailNotification() async {
    final Email email = Email(
      body: '''
Hola $_name,

Tus datos de perfil han sido actualizados correctamente:
- Nombre: $_name
- Email: $_email
- Biografía: $_bio

¡Gracias por mantener tu perfil actualizado!

Atentamente, 
El equipo de Coffee Break
''',
      subject: 'Actualización de Perfil - Coffee Break',
      recipients: [_email],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se ha enviado un correo de confirmación.')),
      );
    } catch (error) {
      print('Error al enviar el correo: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar el correo.')),
      );
    }
  }

  // Método para guardar los cambios y enviar el correo
  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print('Datos guardados:');
      print('Nombre: $_name');
      print('Email: $_email');
      print('Biografía: $_bio');

      
      await _sendEmailNotification();
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
             
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
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

                
                const Text('Email', style: TextStyle(fontSize: 18)),
                TextFormField(
                  initialValue: _email,
                  onSaved: (value) => _email = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El email es obligatorio';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Ingresa un email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                
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
