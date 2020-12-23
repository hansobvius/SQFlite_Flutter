import 'package:flutter_sqflite_example/app/database/base/database/BaseDatabase.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseProvider<T extends BaseDatabase>{

  Database db;
  final T entityDatabase;

  BaseProvider({this.entityDatabase}){
    initDataBase();
  }

  initDataBase() async{
    db = await entityDatabase.getDatabase();
  }
}