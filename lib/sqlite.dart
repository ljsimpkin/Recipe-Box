import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// void initialiseDefaultDatabase() async {};

// void main() async {
//   dataBase();
// }

Future<List> dataBase() async {
  print("yeow");
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'cookBook_database.db'),

    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      print('creating dataBase!!!');
      return db.execute(
        'CREATE TABLE meals(id INTEGER PRIMARY KEY, name TEXT, ingredients TEXT, directions TEXT)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 2,
  );

  // Define a function that inserts meals into the database
  Future<void> insertMeal(Meal meal) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'meals',
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Meal>> meals() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('meals');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Meal(
        id: maps[i]['id'],
        name: maps[i]['name'],
        ingredients: maps[i]['ingredients'],
        directions: maps[i]['directions'],
      );
    });
  }

  // Create a meal and add it to the meals table
  var flatMeal1 = Meal(
    id: 0,
    name: "yum",
    ingredients: "not much",
    directions: "a bit of work aye",
  );

  var flatMeal2 = Meal(
    id: 1,
    name: "yum",
    ingredients: "not much",
    directions: "a bit of work aye",
  );

  var flatMeal3 = Meal(
    id: 2,
    name: "yum",
    ingredients: "not much",
    directions: "a bit of work aye",
  );

  await insertMeal(flatMeal1);
  await insertMeal(flatMeal2);
  await insertMeal(flatMeal3);

  print(await meals());
  return (await meals());
}

class Meal {
  final int id;
  final String name;
  final String ingredients;
  final String directions;

  Meal({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.directions,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'directions': directions,
    };
  }

  @override
  String toString() {
    return '{id: $id, name: $name, ingredients: $ingredients, diretions: $directions}';
  }
}
