import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';  // Asegúrate de importar el paquete de SVG
import 'main.dart';  // Importa tu pantalla principal

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navega a la pantalla principal después de 3 segundos
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),  // Asegúrate de que el nombre de la clase sea correcto
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD7CCC8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Coffe Break',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            SvgPicture.asset(
              'assets/icon/MyIcon.svg',  // Ruta de tu archivo SVG
              width: 150.0,  // Tamaño del ícono (ajustado a un tamaño mayor)
              height: 150.0,
            ),
            const SizedBox(height: 20.0),  // Espacio entre el ícono y el cargador
            const CircularProgressIndicator(),  // Rueda de carga
          ],
        ),
      ),
    );
  }
}
