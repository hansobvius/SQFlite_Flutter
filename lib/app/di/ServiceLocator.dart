import 'package:flutter_sqflite_example/app/database/table/user/content_provider/UserContentProvider.dart';
import 'package:flutter_sqflite_example/app/domain/MainDomain.dart';
import 'package:flutter_sqflite_example/app/store/UserStore.dart';

class ServiceLocator{

  UserContentProvider contentProvider;
  UserStore userStore;
  MainDomain mainDomain;

  ServiceLocator(){
    providerModule();
    domainModule();
    storeModule();
  }

  providerModule() async{
    this.contentProvider = UserContentProvider();
  }

  domainModule(){
    this.mainDomain = MainDomain(contentProvider: contentProvider);
  }

  storeModule(){
    this.userStore = UserStore(mainDomain: mainDomain);
  }
}