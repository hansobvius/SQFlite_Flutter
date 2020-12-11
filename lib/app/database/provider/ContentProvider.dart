import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../DatabaseHelper.dart';

class ContentProvider{

  final String table;

  ContentProvider({this.table});

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await DatabaseHelper.instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await DatabaseHelper.instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row, String columnId) async {
    Database db = await DatabaseHelper.instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete() async {
    Database db = await DatabaseHelper.instance.database;
    return await db.delete(table);
  }
}