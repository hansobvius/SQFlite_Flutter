import 'package:flutter_sqflite_example/app/domain/MainDomain.dart';
import 'package:flutter_sqflite_example/app/model/User.dart';
import 'package:mobx/mobx.dart';

part 'UserStore.g.dart';

class UserStore extends _UserStore with _$UserStore{
  final MainDomain mainDomain;
  UserStore({this.mainDomain}) : super.constructor(mainDomain: mainDomain);
}

abstract class _UserStore with Store{

  final MainDomain mainDomain;

  _UserStore.constructor({this.mainDomain});

  @observable
  ObservableList<User> mUser = ObservableList<User>();

  @action
  void queryUser(){
      mainDomain.query().then((value) =>
        value.forEach((element) {
          mUser.add(User(name: element["name"], value: element["value"]));
        })
      );
  }

  @action
  void insertUser(String name, int value){
    resetUser();
    mainDomain.insert(User(name: name, value: value));
  }

  @action
  void deleteUser(){
    resetUser();
    mainDomain.delete();
  }

  void resetUser(){if(mUser.isNotEmpty) mUser.clear();}
}