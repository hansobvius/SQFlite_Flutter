import 'dart:async';
import 'dart:io';
import 'package:flutter_sqflite_example/app/database/entity/UserDatabase.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  final UserDatabase userDatabase;

  DatabaseHelper.constructor({this.userDatabase});

  static final DatabaseHelper instance = DatabaseHelper.constructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: userDatabase.onCreate);
  }
}
