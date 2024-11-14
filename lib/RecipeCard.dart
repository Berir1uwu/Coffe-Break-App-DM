import 'package:flutter/material.dart';
//import 'recipe_detail_screen.dart'; // El detalle de cada receta

class RecipeCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget screen;
  final String image;

  const RecipeCard({
    super.key,
    required this.title,
    required this.description,
    required this.screen,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}
