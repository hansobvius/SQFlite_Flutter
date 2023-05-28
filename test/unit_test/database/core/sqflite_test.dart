import 'package:flutter_sqflite_example/app/model/User.dart';
import 'package:flutter_test/flutter_test.dart';
import 'test_provider/UserTestContentProvider.dart';

/// To run the following test, execute on the terminal:
/// flutter run test/unit_test/database/core/sqflite_test.dart
///
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  checkInsertDB();
}

void checkInsertDB(){

  late UserTestContentProvider _contentProvider;

  group('Database core test', () {

    setUp((){
      _contentProvider = UserTestContentProvider();
    });

    test('insert data', () async {
      User user = User(name: "name", genre: "male", value: 10,);
      await _contentProvider.insert(user.toMap());
    });

    test('delete data', () async{
      List<User> userList = <User>[];
      final user = await _contentProvider.queryAllRows();
      for(var obj in user){
        userList.add(User().fromMap(obj));
      }
      expect(userList[0].name, 'name');
      expect(userList[0].genre, 'male');
      expect(userList[0].value, 10);
      await _contentProvider.delete();
    });

    test('check database deleted content', () async {
      var user = await _contentProvider.queryAllRows();
      expect(user.length == 0, true);
    });
  });
}