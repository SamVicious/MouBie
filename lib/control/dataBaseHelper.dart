import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _dbName = 'fav.db';
  static final _dbVersion = 1;
  static final _tableName = 'dataTable';
  static final _columnID = '_id';
  static final title = 'original_title';
  static final imageURL = 'poster_path';
  static final overview = 'overview';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    db.execute('''
    CREATE TABLE $_tableName ($_columnID INTEGER PRIMARY KEY,
    $title TEXT NOT NULL,
    $imageURL TEXT NOT NULL,
    $overview TEXT NOT NULL)
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future delete(int id) async {
    Database db = await instance.database;
    return db.delete(_tableName, where: '$_columnID = ?', whereArgs: [id]);
  }
}
