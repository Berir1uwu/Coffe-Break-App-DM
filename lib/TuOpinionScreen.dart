// tu_opinion.dart
import 'package:flutter/material.dart';

class TuOpinionScreen extends StatefulWidget {
  const TuOpinionScreen({super.key});

  @override
  _TuOpinionScreenState createState() => _TuOpinionScreenState();
}

class _TuOpinionScreenState extends State<TuOpinionScreen> {
  // Controlador para el campo de texto
  final TextEditingController _opinionController = TextEditingController();
  String _opinion = '';

  @override
  void dispose() {
    _opinionController.dispose();
    super.dispose();
  }

  // Función para manejar el envío de la opinión
  void _submitOpinion() {
    setState(() {
      _opinion = _opinionController.text;
    });

    // Aquí puedes agregar lógica para guardar la opinión (por ejemplo, en una base de datos, almacenamiento local, etc.)
    // Mostrar una notificación o un mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gracias por tu opinión!')),
    );

    // Limpiar el campo de texto después de enviar
    _opinionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Opinión'),
        backgroundColor: const Color(0xFFCD5C5C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¡Nos gustaría saber tu opinión sobre la aplicación!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Campo de texto para la opinión
            TextField(
              controller: _opinionController,
              maxLines: 5, // Permite múltiples líneas
              decoration: const InputDecoration(
                hintText: 'Escribe tu opinión aquí...',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitOpinion,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFCD5C5C),
              ),
              child: const Text('Enviar Opinión'),
            ),
            const SizedBox(height: 20),
            if (_opinion.isNotEmpty) ...[
              const Text(
                'Tu Opinión:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                _opinion,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
