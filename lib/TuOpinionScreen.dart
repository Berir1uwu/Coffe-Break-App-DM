import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TuOpinionScreen extends StatefulWidget {
  const TuOpinionScreen({super.key});

  @override
  _TuOpinionScreenState createState() => _TuOpinionScreenState();
}

class _TuOpinionScreenState extends State<TuOpinionScreen> {
  // Controlador para el campo de texto
  final TextEditingController _opinionController = TextEditingController();
  String _opinion = '';

  // Variables para almacenar las preguntas cargadas del JSON
  List<dynamic> usabilidad = [];
  List<dynamic> contenido = [];
  List<dynamic> compartir = [];

  @override
  void initState() {
    super.initState();
    // Cargar el archivo JSON al inicio
    _loadJsonData();
  }

  // Cargar datos del archivo JSON
  Future<void> _loadJsonData() async {
    final String response = await rootBundle.loadString('assets/usabilidad.json');
    final data = json.decode(response);

    setState(() {
      usabilidad = data['usabilidad'];
      contenido = data['contenido'];
      compartir = data['compartir'];
    });
  }

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
            // Mostrar las preguntas cargadas del JSON
            _buildQuestionsSection('Usabilidad', usabilidad),
            const SizedBox(height: 20),
            _buildQuestionsSection('Contenido', contenido),
            const SizedBox(height: 20),
            _buildQuestionsSection('Compartir', compartir),
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

  // Función para construir una sección de preguntas
  Widget _buildQuestionsSection(String title, List<dynamic> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...questions.map((question) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question['titulo'], style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text('Mínimo: ${question['min']}', style: const TextStyle(fontSize: 14)),
                Text('Máximo: ${question['max']}', style: const TextStyle(fontSize: 14)),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
