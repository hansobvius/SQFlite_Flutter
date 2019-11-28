import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
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
                                    'ROW ${index + 1}: NAME ${snapshot.data[index].mName} VALUE ${snapshot.data[index].mValue}'
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
      DatabaseHelper.columnName : name,
      DatabaseHelper.columnValue  : value
    };
    await dbHelper.insert(row);
    _query();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row){
      mUser.add(
          User(
              mName: row['name'],
              mValue: row['value']
          )
      );
      _streamUserController.sink.add(mUser);
      print(row);
      print(mUser);
    });
  }

  void _delete() async {
    await dbHelper.delete();
    mUser.clear();
    _streamUserController.sink.add(mUser);
  }
}
