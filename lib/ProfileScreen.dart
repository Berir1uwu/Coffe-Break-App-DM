import 'package:flutter/material.dart';

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