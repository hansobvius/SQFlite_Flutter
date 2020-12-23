import 'package:flutter_sqflite_example/app/database/user/provider/ContentProvider.dart';
import 'package:flutter_sqflite_example/app/model/User.dart';

class MainDomain{

  final ContentProvider contentProvider;

  MainDomain({this.contentProvider});

  void insert(Map<String, dynamic> userRow) async {
    await contentProvider.insert(userRow);
  }

  Future<List<Map<String, dynamic>>> query() async {
    return await contentProvider.queryAllRows();
  }

  void delete() async {
    await contentProvider.delete();
  }
}
