import 'file:///C:/Users/cin_tcaiado/FlutterProjects/SQFlite_Flutter/lib/app/database/base/provider/BaseProvider.dart';
import 'package:flutter_sqflite_example/app/database/base/provider/IProvider.dart';
import 'package:sqflite/sqflite.dart';
import '../helper/UserDatabaseHelper.dart';

class UserContentProvider extends BaseProvider<UserDatabaseHelper> implements IProvider{

  UserContentProvider() : super(entityDatabase: UserDatabaseHelper.instance);

  @override
  Future<int> insert(Map<String, dynamic> row) async {
    return await db.insert(entityDatabase.table, row);
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    if(db == null) await initDataBase();
    return await db.query(entityDatabase.table);
  }

  @override
  Future<int> queryRowCount() async {
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $entityDatabase.table')
    );
  }

  @override
  Future<int> update(Map<String, dynamic> row, String columnId) async {
    return await db.update(entityDatabase.table, row, where: '$columnId = ?', whereArgs: [row[columnId]]);
  }

  @override
  Future<int> delete() async {
    return await db.delete(entityDatabase.table);
  }
}