import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:io';

abstract class BaseDatabase{

  final String _databaseName;
  final int _version;

  BaseDatabase(String databaseName, int version) :
      _databaseName = databaseName,
      _version = version;

  Future<Database> getDatabase();

  String entityTable();

  Future<String> createDir() async {
    final Directory documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
    final String path = await join(documentsDirectory.path, _databaseName);
    return path;
  }

  Future<void> onCreate(Database db, int version) async{
    await db.execute(entityTable());
  }

  Future<Database> initDatabase() async {
    String path = await createDir();
    return await openDatabase(path, version: _version, onCreate: onCreate);
  }
}