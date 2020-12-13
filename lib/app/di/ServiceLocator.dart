import 'dart:async';
import 'package:flutter_sqflite_example/app/database/entity/UserDatabase.dart';
import 'package:flutter_sqflite_example/app/database/helper/DatabaseHelper.dart';
import 'package:flutter_sqflite_example/app/database/provider/ContentProvider.dart';
import 'package:flutter_sqflite_example/app/domain/MainDomain.dart';
import 'package:flutter_sqflite_example/app/model/User.dart';
import 'package:flutter_sqflite_example/app/store/UserStore.dart';

class ServiceLocator{

  StreamController<List<User>> streamUserController;
  DatabaseHelper dbHelper;
  UserDatabase userDatabase;
  ContentProvider contentProvider;
  UserStore userStore;
  MainDomain mainDomain;

  ServiceLocator(){
    this.streamUserController = StreamController<List<User>>();
    this.userDatabase = UserDatabase();
    this.dbHelper = DatabaseHelper.constructor(userDatabase: userDatabase);
    this.contentProvider = ContentProvider(table: "my_table");
    this.mainDomain = MainDomain(contentProvider: contentProvider, userDatabase: userDatabase);
    this.userStore = UserStore(mainDomain: mainDomain);
  }
}