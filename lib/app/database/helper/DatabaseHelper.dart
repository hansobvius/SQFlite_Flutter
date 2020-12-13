import 'dart:async';
import 'dart:io';
import 'package:flutter_sqflite_example/app/database/BaseDatabase.dart';
import 'package:flutter_sqflite_example/app/database/entity/UserDatabase.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper extends BaseDatabase{

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  final UserDatabase userDatabase;

  DatabaseHelper.constructor({this.userDatabase}): super(_databaseName, _databaseVersion);

  static final DatabaseHelper instance = DatabaseHelper.constructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Directory> createDir() async => await getApplicationDocumentsDirectory();

  @override
  Future<void> open(Database db, int version) => userDatabase.onCreate(db, version);
}
