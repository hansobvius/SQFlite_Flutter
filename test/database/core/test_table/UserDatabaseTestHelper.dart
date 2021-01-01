import 'package:flutter_sqflite_example/app/database/base/database/BaseDatabase.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDatabaseTestHelper extends BaseDatabase{

  static final _databaseName = "TestDatabase.db";
  static final _databaseVersion = 1;

  static final  String _table = "my_table";
  String get table => _table;

  final columnId = '_id';
  final columnName = 'name';
  final columnGenre = 'genre';
  final columnValue = 'value';

  UserDatabaseTestHelper(): super(_databaseName, _databaseVersion, _table);
  static final UserDatabaseTestHelper instance = UserDatabaseTestHelper();

  @override
  String entityTable() => '''
          CREATE TABLE $table (
            $columnId    INTEGER PRIMARY KEY,
            $columnName  TEXT NOT NULL,
            $columnValue INTEGER NOT NULL
          )
          ''';

  @override
  Future<Database> getDatabase() async => getInitDatabase();
}
