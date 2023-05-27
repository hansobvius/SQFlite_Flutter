import 'package:flutter_sqflite_example/app/database/base/provider/BaseProvider.dart';
import 'package:flutter_sqflite_example/app/database/base/provider/IProvider.dart';
import 'package:sqflite/sqflite.dart';
import '../helper/UserDatabaseHelper.dart';

class UserContentProvider extends BaseProvider<UserDatabaseHelper> implements IProvider{

  UserContentProvider() : super(entityDatabase: UserDatabaseHelper.instance);

  @override
  Future<int> insert(Map<String, dynamic> row) async {
    if (db == null) throw('Database not initialized');
    return await db!.insert(entityDatabase.table, row, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    if (db == null) throw('Database not initialized');
    return await db!.query(entityDatabase.table);
  }

  @override
  Future<int> queryRowCount() async {
    if (db == null) throw('Database not initialized');
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $entityDatabase.table')
    ) ?? 0;
  }

  @override
  Future<int> update(Map<String, dynamic> row, String columnId) async {
    if (db == null) throw('Database not initialized');
    return await db!.update(entityDatabase.table, row, where: '$columnId = ?', whereArgs: [row[columnId]]);
  }

  @override
  Future<int> delete() async {
    if (db == null) throw('Database not initialized');
    return await db!.delete(entityDatabase.table);
  }
}