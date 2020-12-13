import 'file:///C:/Users/cin_tcaiado/FlutterProjects/SQFlite_Flutter/lib/app/database/helper/DBContract.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDatabase extends BaseContract{

  static final table = 'my_table';
  final columnId = '_id';
  final columnName = 'name';
  final columnValue = 'value';

  final Database db;

  UserDatabase({this.db});

  @override
  String entityTable() => '''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnValue INTEGER NOT NULL
          )
          ''';

  @override
  Future<void> onCreate(Database db, int version) async{
    await db.execute(entityTable());
  }
}