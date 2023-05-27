import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

abstract class BaseDatabase{

  late final Database _database;

  final String _databaseName;
  final int _version;

  BaseDatabase(String databaseName, int version) :
    _databaseName = databaseName,
    _version = version;

  Future<Database> getDatabase();

  String entityTable();

  List<String> alterTable();

  Future<String> createDir() async {
    final Directory documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);
    return path;
  }

  Future<Database> getInitDatabase() async{
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = await createDir();
    return await openDatabase(
        path,
        version: _version,
        onCreate: _onCreate,
        onUpgrade: _onUpdate);
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute(entityTable());
  }

  Future<void> _onUpdate(Database db, int oldVersion, int newVersion) async{
    var batch =  db.batch();
    if(oldVersion < newVersion){
      if(alterTable() != null && alterTable().isNotEmpty){
        alterTable().forEach((alterTable) {
          batch.execute(alterTable);
        });
      }
    }
  }
}