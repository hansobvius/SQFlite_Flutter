import 'package:flutter_sqflite_example/app/database/base/database/BaseDatabase.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDatabaseTestHelper extends BaseDatabase{

  static final _databaseName = "TestDatabase.db";
  static final _databaseVersion = 2;

  UserDatabaseTestHelper(): super(_databaseName, _databaseVersion);
  static final UserDatabaseTestHelper instance = UserDatabaseTestHelper();

  final table = "test_table";
  final columnId = '_id';
  final columnName = 'name';
  final columnGenre = 'genre';
  final columnValue = 'value';

  @override
  String entityTable() => '''
          CREATE TABLE $table (
            $columnId    INTEGER PRIMARY KEY,
            $columnName  TEXT NOT NULL,
            $columnGenre TEXT,
            $columnValue INTEGER NOT NULL
          )
          ''';

  @override
  Future<Database> getDatabase() async => getInitDatabase();

  @override
  List<String> alterTable() => ['ALTER TABLE $table ADD COLUMN $columnGenre'];
}
