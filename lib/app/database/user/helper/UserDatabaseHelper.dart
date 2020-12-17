import 'dart:async';
import 'dart:io';
import 'package:flutter_sqflite_example/app/database/BaseDatabase.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../../DBContract.dart';

class UserDatabaseHelper extends BaseDatabase{

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;
  static Database _database;

  final table = 'my_table';
  final columnId = '_id';
  final columnName = 'name';
  final columnValue = 'value';

  UserDatabaseHelper.constructor(): super(_databaseName, _databaseVersion);

  static final UserDatabaseHelper instance = UserDatabaseHelper.constructor();

  @override
  String entityTable() => '''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnValue INTEGER NOT NULL
          )
          ''';

  @override
  Future<Database> getDatabase() async{
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }
}
