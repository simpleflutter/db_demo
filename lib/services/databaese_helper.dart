import 'dart:core';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  //private consturctor
  DatabaseHelper._();

  // static reference for singletone clas
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;

    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'students.db');

    Database db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'create table students(id integer primary key autoincrement, name text, branch text)');
  }
}
