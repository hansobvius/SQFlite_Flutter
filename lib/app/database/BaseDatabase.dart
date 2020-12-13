import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'dart:io';

abstract class BaseDatabase{

  final String _databaseName;
  final int _version;

  BaseDatabase(String databaseName, int version) :
        _databaseName = databaseName,
        _version = version;

  Future<void> open(Database db, int version);

  Future<Directory> createDir() async => await getApplicationDocumentsDirectory();

  Future<Database> initDatabase() async => await _onCreate();

  Future<Database> _onCreate() async {
    Directory documentsDirectory = await createDir();
    String path = join(documentsDirectory.path, _databaseName);
    return openDatabase(path,
        version: _version,
        onCreate: open);
  }
}