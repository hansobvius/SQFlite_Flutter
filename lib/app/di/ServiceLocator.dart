import 'dart:async';
import 'package:flutter_sqflite_example/app/database/user/helper/UserDatabaseHelper.dart';
import 'package:flutter_sqflite_example/app/database/user/provider/ContentProvider.dart';
import 'package:flutter_sqflite_example/app/domain/MainDomain.dart';
import 'package:flutter_sqflite_example/app/model/User.dart';
import 'package:flutter_sqflite_example/app/store/UserStore.dart';

class ServiceLocator{

  StreamController<List<User>> streamUserController;
  UserDatabaseHelper dbHelper;
  ContentProvider contentProvider;
  UserStore userStore;
  MainDomain mainDomain;

  ServiceLocator(){
    providerModule();
    this.streamUserController = StreamController<List<User>>();
    this.dbHelper = UserDatabaseHelper.constructor();
    this.mainDomain = MainDomain(contentProvider: contentProvider);
    this.userStore = UserStore(mainDomain: mainDomain);
  }

  providerModule(){
    this.contentProvider = ContentProvider();
  }
}