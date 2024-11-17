import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart'; // Importa el paquete para enviar correos
import 'package:coffebreakapp/DatabaseHelper.dart'; // Importa tu clase de base de datos

class TuOpinionScreen extends StatefulWidget {
  const TuOpinionScreen({super.key});

  @override
  _TuOpinionScreenState createState() => _TuOpinionScreenState();
}

class _TuOpinionScreenState extends State<TuOpinionScreen> {
  final TextEditingController _opinionController = TextEditingController();
  String _opinion = '';
  List<dynamic> usabilidad = [];
  List<dynamic> contenido = [];
  List<dynamic> compartir = [];
  final Map<String, double> _ratings = {};

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

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

  void _submitOpinion() async {
    if (_opinionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, escribe tu opinión antes de enviar.')),
      );
      return;
    }

    // Guardar calificaciones y opinión en la base de datos
    final opinionData = {
      'usabilidad': _ratings['Usabilidad'] ?? 0,
      'contenido': _ratings['Contenido'] ?? 0,
      'compartir': _ratings['Compartir'] ?? 0,
      'opinion': _opinionController.text,
    };

    // Insertar los datos en la base de datos
    await DatabaseHelper.instance.insertOpinion(opinionData);

    // Enviar correo con las respuestas
    final Email email = Email(
      body: '''
      Opinión recibida:
      
      Usabilidad: ${_ratings['Usabilidad'] ?? 0}
      Contenido: ${_ratings['Contenido'] ?? 0}
      Compartir: ${_ratings['Compartir'] ?? 0}
      Opinión escrita: ${_opinionController.text}
      ''',
      subject: 'Nueva Opinión de Usuario',
      recipients: ['javiera.belen.b.h@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      // Mostrar mensaje de agradecimiento
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gracias por tu opinión!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al enviar el correo.')),
      );
    }

    // Limpiar campo de texto y estado
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
              _buildQuestionsSection('Usabilidad', usabilidad),
              const SizedBox(height: 20),
              _buildQuestionsSection('Contenido', contenido),
              const SizedBox(height: 20),
              _buildQuestionsSection('Compartir', compartir),
              const SizedBox(height: 20),
              TextField(
                controller: _opinionController,
                maxLines: 5,
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
