import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../DatabaseHelper.dart';

class ContentProvider{

  final String table;
  DatabaseHelper db;

  ContentProvider({this.table, this.db});

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    var db = await this.db.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    var db = await this.db.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> update(Map<String, dynamic> row, String columnId) async {
    var db = await this.db.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete() async {
    var db = await this.db.database;
    return await db.delete(table);
  }
}