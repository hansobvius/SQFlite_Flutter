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

  Future<String> createDir() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return path;
  }
}