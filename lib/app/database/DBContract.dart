import 'dart:async';

import 'package:sqflite/sqlite_api.dart';

abstract class BaseContract{

  Future<Database> getDatabase();

  Future<void> onCreate(Database db, int version);

  String entityTable();

}