import 'package:flutter_sqflite_example/app/database/entity/UserDatabase.dart';
import 'package:flutter_sqflite_example/app/database/provider/ContentProvider.dart';

class MainDomain{

  final ContentProvider contentProvider;
  final UserDatabase userDatabase;

  MainDomain({this.contentProvider, this.userDatabase});

  void insert(String name, int value) async {
    Map<String, dynamic> row = {
      userDatabase.columnName : name,
      userDatabase.columnValue  : value
    };
    await contentProvider.insert(row);
  }

  Future<List<Map<String, dynamic>>> query() async {
    return await contentProvider.queryAllRows();
  }

  void delete() async {
    await contentProvider.delete();
  }
}
