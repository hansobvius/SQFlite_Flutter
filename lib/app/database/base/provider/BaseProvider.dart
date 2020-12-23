import 'package:flutter_sqflite_example/app/database/base/database/BaseDatabase.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseProvider<T extends BaseDatabase>{

  final T entityDatabase;

  Database _db;
  Database get db => _db;

  BaseProvider({this.entityDatabase}){
    initDataBase();
  }

  initDataBase() async{
    _db = await entityDatabase.getDatabase();
  }
}