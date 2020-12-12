import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/app/di/ServiceLocator.dart';
import '../database/DatabaseHelper.dart';
import '../database/entity/UserDatabase.dart';
import '../database/provider/ContentProvider.dart';
import '../model/User.dart';

class Home extends StatefulWidget{

  final ServiceLocator serviceLocator;

  Home({this.serviceLocator});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  List<User> mUser = [];
  User userModel = User();

  @override
  void initState(){
    _query();
    super.initState();
  }

  @override
  void dispose(){
    widget.serviceLocator.streamUserController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("SQFLite App"),
      ),
      body: SafeArea(
        child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: StreamBuilder<List<User>>(
                    stream: widget.serviceLocator.streamUserController.stream,
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
      ),
    );
  }

  void _insert(String name, int value) async {
    mUser.clear();
    Map<String, dynamic> row = {
      widget.serviceLocator.userDatabase.columnName : name,
      widget.serviceLocator.userDatabase.columnValue  : value
    };
    await widget.serviceLocator.contentProvider.insert(row);
    _query();
  }

  void _query() async {
    final allRows = await widget.serviceLocator.contentProvider.queryAllRows();
    allRows.forEach((row){
      mUser.add(
          User(
              name: row['name'],
              value: row['value']
          )
      );
      widget.serviceLocator.streamUserController.sink.add(mUser);
      print(row);
      print(mUser);
    });
  }

  void _delete() async {
    await widget.serviceLocator.contentProvider.delete();
    mUser.clear();
    widget.serviceLocator.streamUserController.sink.add(mUser);
  }
}
