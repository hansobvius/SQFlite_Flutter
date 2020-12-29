import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_model/User.dart';
import 'test_provider/UserTestContentProvider.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  checkInsertDB();
}

void checkInsertDB(){
  group('Database core test', () {
    final UserTestContentProvider contentProvider = UserTestContentProvider();
    test('insert data', () async {
      User user = User(name: "Thiago", value: 10);
      await contentProvider.insert(user.toMap());
    });
    test('check data', () async{
      List<User> userList = <User>[];
      final user = await contentProvider.queryAllRows();
      for(var obj in user){
        userList.add(User().fromMap(obj));
      }
      expect(userList[0].name, 'name');
      expect(userList[0].value, 10);
      await contentProvider.delete();
    });
  });
}