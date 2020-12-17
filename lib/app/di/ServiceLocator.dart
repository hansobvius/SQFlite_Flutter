import 'dart:async';
import 'package:flutter_sqflite_example/app/database/user/helper/UserDatabaseHelper.dart';
import 'package:flutter_sqflite_example/app/database/user/provider/ContentProvider.dart';
import 'package:flutter_sqflite_example/app/domain/MainDomain.dart';
import 'package:flutter_sqflite_example/app/model/User.dart';
import 'package:flutter_sqflite_example/app/store/UserStore.dart';

class ServiceLocator{

  ContentProvider contentProvider;
  UserStore userStore;
  MainDomain mainDomain;

  ServiceLocator(){
    providerModule();
    domainModule();
    storeModule();
  }

  providerModule() async{
    this.contentProvider = ContentProvider();
  }

  domainModule(){
    this.mainDomain = MainDomain(contentProvider: contentProvider);
  }

  storeModule(){
    this.userStore = UserStore(mainDomain: mainDomain);
  }
}