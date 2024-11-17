import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Recipe.dart'; 

class DatabaseHelper {
  static const _databaseName = 'recipes.db';
  static const _databaseVersion = 1;

  static const table = 'recipes';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnImage = 'image';
  static const columnDescription = 'description';
  static const columnIngredients = 'ingredients';
  static const columnInstructions = 'instructions';

  
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializar la base de datos
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Crear la tabla
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT,
        $columnImage TEXT,
        $columnDescription TEXT,
        $columnIngredients TEXT,
        $columnInstructions TEXT
      )
    ''');
  }

  // Insertar una nueva receta
  Future<int> insertRecipe(Recipe recipe) async {
    Database db = await instance.database;
    return await db.insert(table, recipe.toMap());
  }

  // Obtener todas las recetas
  Future<List<Recipe>> getAllRecipes() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return Recipe.fromMap(maps[i]);
    });
  }

  insertOpinion(Map<String, Object> opinionData) {}
}
