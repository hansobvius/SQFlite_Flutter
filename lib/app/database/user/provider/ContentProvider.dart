import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../helper/UserDatabaseHelper.dart';

class ContentProvider{

  UserDatabaseHelper _userDatabaseHelper;
  Database _db;
  String _table;

  ContentProvider() {
    this._userDatabaseHelper = UserDatabaseHelper.instance;
    _initContentProvider();
  }

  Future _initContentProvider() async {
    this._db = await _userDatabaseHelper.database;
    this._table = _userDatabaseHelper.table;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(_table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(_table);
  }

  Future<int> queryRowCount() async {
    return Sqflite.firstIntValue(
        await _db.rawQuery('SELECT COUNT(*) FROM $_table')
    );
  }

  Future<int> update(Map<String, dynamic> row, String columnId) async {
    int id = row[columnId];
    return await _db.update(_table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete() async {
    return await _db.delete(_table);
  }
}