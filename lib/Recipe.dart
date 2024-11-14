class Recipe {
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String image;

  Recipe({
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.image,
  });

  // Método para convertir un JSON en un objeto Recipe
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      description: json['description'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
      image: json['image'],
    );
  }

  // Método para convertir un objeto Recipe en JSON (si necesitas guardar o enviar)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
      'image': image,
    };
  }
}