import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'database/DatabaseHelper.dart';
import 'database/entity/UserDatabase.dart';
import 'database/provider/ContentProvider.dart';
import 'model/User.dart';

class HomePageState extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePageState>{

  List<User> mUser = [];
  User userModel = User();
  final StreamController<List<User>> _streamUserController = StreamController<List<User>>();
  final dbHelper = DatabaseHelper.instance;
  final UserDatabase userDatabase = UserDatabase();
  final ContentProvider contentProvider = ContentProvider(table: "my_table");

  @override
  void initState(){
    _query();
    super.initState();
  }

  @override
  void dispose(){
    _streamUserController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: StreamBuilder<List<User>>(
                  stream: _streamUserController.stream,
                  initialData: mUser,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                                child: Text(
                                    'ROW ${index + 1}: NAME ${snapshot.data[index].name} VALUE ${snapshot.data[index].value}'
                                )
                            );
                          }
                      );
                    }else{
                      return Text('NOPE');
                    }
                  }
                )
              ),
            ),
            Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      child: Text('insert', style: TextStyle(fontSize: 14),),
                      onPressed: (){
                        _insert('Thiago', Random().nextInt(10));
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      child: Text('delete', style: TextStyle(fontSize: 14),),
                      onPressed: (){
                        _delete();
                      },
                    ),
                  ),
                ]
            )
          ]
      ),
    );
  }

  void _insert(String name, int value) async {
    mUser.clear();
    Map<String, dynamic> row = {
      userDatabase.columnName : name,
      userDatabase.columnValue  : value
    };
    await contentProvider.insert(row);
    _query();
  }

  void _query() async {
    final allRows = await contentProvider.queryAllRows();
    allRows.forEach((row){
      mUser.add(
          User(
              name: row['name'],
              value: row['value']
          )
      );
      _streamUserController.sink.add(mUser);
      print(row);
      print(mUser);
    });
  }

  void _delete() async {
    await contentProvider.delete();
    mUser.clear();
    _streamUserController.sink.add(mUser);
  }
}
