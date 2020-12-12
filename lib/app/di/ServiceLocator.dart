import 'dart:async';
import 'package:flutter_sqflite_example/app/database/DatabaseHelper.dart';
import 'package:flutter_sqflite_example/app/database/entity/UserDatabase.dart';
import 'package:flutter_sqflite_example/app/database/provider/ContentProvider.dart';
import 'package:flutter_sqflite_example/app/model/User.dart';
import 'package:flutter_sqflite_example/app/store/UserStore.dart';

class ServiceLocator{

  StreamController<List<User>> streamUserController;
  DatabaseHelper dbHelper;
  UserDatabase userDatabase;
  ContentProvider contentProvider;

  ServiceLocator(){
    this.streamUserController = StreamController<List<User>>();
    this.dbHelper = DatabaseHelper.instance;
    this.userDatabase = UserDatabase();
    this.contentProvider = ContentProvider(table: "my_table");
  }
}