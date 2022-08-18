import 'dart:developer';

import 'package:path/path.dart';
import 'package:restaurant_app/data/model/restaurants_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  static const String _tableName = "restaurant";
  static late Database _database;

  Future<Database> get database async {
    _database = await initializeDb();
    return _database;
  }

  Future<Database> initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'restaurant_db.db'),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating DOUBLE)''');
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertRestaurant(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toJson());
    log('Data has been saved');
  }

  Future<void> deleteRestaurant(Restaurant restaurant) async {
    final Database db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
    log('Data has been deleted');
  }

  Future<bool> getRestaurantById(Restaurant restaurant) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );

    return results.isNotEmpty ? true : false;
  }

  Future<List<Restaurant>> getRestaurants() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((e) => Restaurant.fromJson(e)).toList();
  }
}
