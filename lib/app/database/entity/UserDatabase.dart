import 'package:flutter_sqflite_example/app/database/DBContract.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDatabase extends BaseContract{

  static final table = 'my_table';
  final columnId = '_id';
  final columnName = 'name';
  final columnValue = 'value';

  final Database db;

  UserDatabase({this.db});

  @override
  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnValue INTEGER NOT NULL
          )
          ''');
  }
}