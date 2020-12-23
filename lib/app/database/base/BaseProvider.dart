import 'package:sqflite/sqflite.dart';
import 'BaseDatabase.dart';

abstract class BaseProvider<T extends BaseDatabase>{

  Database db;
  final T entityDatabase;

  BaseProvider({this.entityDatabase}){
    initDataBase();
  }

  initDataBase() async{
    db = await entityDatabase.getDatabase();
  }

  Future<int> insert(Map<String, dynamic> row);

  Future<List<Map<String, dynamic>>> queryAllRows();

  Future<int> queryRowCount();

  Future<int> update(Map<String, dynamic> row, String columnId);

  Future<int> delete();
}