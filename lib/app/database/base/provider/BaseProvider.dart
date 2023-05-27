import 'package:flutter_sqflite_example/app/database/base/database/BaseDatabase.dart';
import 'package:sqflite/sqflite.dart';

import 'IProvider.dart';

abstract class BaseProvider<T extends BaseDatabase> implements IProvider {

  final T entityDatabase;

  Database? _db;
  Database? get db => _db;

  Future<Database?> getDatabase() async {
    if (_db == null) {
      _db = await entityDatabase.getDatabase();
      return _db;
    }
    return _db;
  }

  BaseProvider({required this.entityDatabase}){
    initDataBase();
  }

  initDataBase() async {
    _db = await entityDatabase.getDatabase();
  }
}