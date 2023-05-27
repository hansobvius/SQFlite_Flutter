import 'package:flutter_sqflite_example/app/database/base/provider/BaseProvider.dart';
import 'package:flutter_sqflite_example/app/database/base/provider/IProvider.dart';
import 'package:sqflite/sqflite.dart';
import '../test_table/UserDatabaseTestHelper.dart';

class UserTestContentProvider extends BaseProvider<UserDatabaseTestHelper> implements IProvider{

  UserTestContentProvider() : super(entityDatabase: UserDatabaseTestHelper.instance);

  @override
  Future<int> insert(Map<String, dynamic> row) async {
    if(db == null) await initDataBase();
    return await db!.insert(entityDatabase.table, row);
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    if(db == null) await initDataBase();
    return await db!.query(entityDatabase.table);
  }

  @override
  Future<int> queryRowCount() async {
    if(db == null) await initDataBase();
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $entityDatabase.table')
    ) ?? 0;
  }

  @override
  Future<int> update(Map<String, dynamic> row, String columnId) async {
    if(db == null) await initDataBase();
    return await db!.update(entityDatabase.table, row, where: '$columnId = ?', whereArgs: [row[columnId]]);
  }

  @override
  Future<int> delete() async {
    if(db == null) await initDataBase();
    return await db!.delete(entityDatabase.table);
  }
}