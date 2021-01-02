import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_sqflite_example/app/di/ServiceLocator.dart';
import 'package:flutter_sqflite_example/app/store/UserStore.dart';
import '../model/User.dart';

class Home extends StatefulWidget{

  final ServiceLocator serviceLocator;

  Home({this.serviceLocator});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  UserStore _store;
  List<User> mUserList;

  @override
  void initState(){
    _store = widget.serviceLocator.userStore
     ..queryUser();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  void insertData(String name, String genre, int value){
    _store..insertUser(name, genre, value)..queryUser();
  }

  void deleteData(){
    _store..deleteUser()..queryUser();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("SQFLite App"),
      ),
      body: SafeArea(
        child: Observer(
          builder: (_){
            return (_store.mUser.length != null || _store.mUser.length != 0) ? Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemCount: _store.mUser.length,
                        itemBuilder: (BuildContext context, int index){
                          return Container(
                            child: Text(
                                'ROW ${index + 1}: '
                                    'NAME ${_store.mUser[index].name ?? ''} '
                                    'GENRE ${_store.mUser[index].genre ?? ''} '
                                    'VALUE ${_store.mUser[index].value ?? ''}'
                            )
                          );
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
                            this.insertData('Thiago', 'male', Random().nextInt(10));
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          child: Text('delete', style: TextStyle(fontSize: 14),),
                          onPressed: (){
                            this.deleteData();
                          },
                        ),
                      ),
                    ]
                  )
                ]
            ) : Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }
}
