import 'package:flutter_sqflite_example/app/domain/MainDomain.dart';
import 'package:flutter_sqflite_example/app/model/User.dart';
import 'package:mobx/mobx.dart';

part 'UserStore.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store{

  final MainDomain mainDomain;

  _UserStore.UserStore({this.mainDomain});

  @observable
  List<User> mUser;

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
    mainDomain.insert(name, value);
  }

  @action
  void deleteUser(){
    mainDomain.delete();
  }
}