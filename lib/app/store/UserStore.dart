import 'package:flutter_sqflite_example/app/domain/MainDomain.dart';
import 'package:flutter_sqflite_example/app/model/User.dart';
import 'package:mobx/mobx.dart';

part 'UserStore.g.dart';

class UserStore extends _UserStore with _$UserStore{
  final MainDomain mainDomain;
  UserStore({required this.mainDomain}) : super.constructor(mainDomain: mainDomain);
}

abstract class _UserStore with Store{

  final MainDomain mainDomain;

  _UserStore.constructor({required this.mainDomain});

  @observable
  ObservableList<User> mUser = ObservableList<User>();

  @action
  Future queryUser() async{
    var query =  await mainDomain.query();
    query.forEach((element) {
      mUser.add(User.instance().fromMap(element));
    });
  }

  @action
  void insertUser(String name, String genre, int value){
    resetUser();
    mainDomain.insert(User(name: name, value: value).toMap());
  }

  @action
  void deleteUser(){
    resetUser();
    mainDomain.delete();
  }

  void resetUser(){
    if(mUser.isNotEmpty) mUser.clear();
  }
}