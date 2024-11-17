import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TuOpinionScreen extends StatefulWidget {
  const TuOpinionScreen({super.key});

  @override
  _TuOpinionScreenState createState() => _TuOpinionScreenState();
}

class _TuOpinionScreenState extends State<TuOpinionScreen> {
  // Controlador para el campo de texto
  final TextEditingController _opinionController = TextEditingController();
  String _opinion = '';

  // Variables para almacenar las preguntas cargadas del JSON y sus calificaciones
  List<dynamic> usabilidad = [];
  List<dynamic> contenido = [];
  List<dynamic> compartir = [];

  // Mapas para guardar las calificaciones seleccionadas por el usuario
  final Map<String, double> _ratings = {};

  @override
  void initState() {
    super.initState();
    // Cargar el archivo JSON al inicio
    _loadJsonData();
  }

  // Cargar datos del archivo JSON
  Future<void> _loadJsonData() async {
    try {
      final String response = await rootBundle.loadString('assets/usabilidad.json');
      final Map<String, dynamic> data = json.decode(response);

      setState(() {
        usabilidad = data['usabilidad'] ?? [];
        contenido = data['contenido'] ?? [];
        compartir = data['compartir'] ?? [];
      });
    } catch (e) {
      // Mostrar un mensaje de error si hay un problema al cargar el JSON
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cargar el archivo JSON')),
      );
    }
  }

  @override
  void dispose() {
    _opinionController.dispose();
    super.dispose();
  }

  // Función para manejar el envío de la opinión
  void _submitOpinion() {
    if (_opinionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, escribe tu opinión antes de enviar.')),
      );
      return;
    }

    // Mostrar calificaciones y opinión en consola (puedes enviar esto a un backend si lo necesitas)
    print('Calificaciones: $_ratings');
    print('Opinión: $_opinion');

    // Mostrar una notificación o un mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gracias por tu opinión!')),
    );

    // Limpiar el campo de texto después de enviar
    _opinionController.clear();
    setState(() {
      _opinion = '';
    });
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
        child: SingleChildScrollView(
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
      ),
    );
  }

  // Función para construir una sección de preguntas con calificación por estrellas
  Widget _buildQuestionsSection(String title, List<dynamic> questions) {
    if (questions.isEmpty) {
      return Text(
        'No se encontraron preguntas para $title.',
        style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...questions.map((question) {
          final String questionTitle = question['titulo'] ?? 'Sin título';

          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(questionTitle, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                RatingBar.builder(
                  initialRating: _ratings[questionTitle] ?? 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _ratings[questionTitle] = rating;
                    });
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
