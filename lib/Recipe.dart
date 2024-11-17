class Recipe {
  final int? id;
  final String name;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String image;

  Recipe({
    this.id,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.image,
  });

  // Método para convertir un JSON en un objeto Recipe (para usar cuando obtienes datos en formato JSON, como de una API)
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
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

  // Convertir la receta en un Map<String, dynamic> para guardarla en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'ingredients': ingredients.join(','), // Convierte la lista de ingredientes en un string
      'instructions': instructions.join(','), // Convierte la lista de instrucciones en un string
      'image': image,
    };
  }

  // Crear una receta a partir de un Map<String, dynamic> (como cuando se obtiene de la base de datos)
  static Recipe fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      ingredients: (map['ingredients'] as String).split(','), // Convierte el string de vuelta a lista
      instructions: (map['instructions'] as String).split(','), // Convierte el string de vuelta a lista
      image: map['image'],
    );
  }
}
