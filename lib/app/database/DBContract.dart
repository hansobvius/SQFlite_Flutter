import 'dart:async';

import 'package:sqflite/sqlite_api.dart';

abstract class BaseContract{

  Future<void> onCreate(Database db, int version);
}