import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';

class HomePageState extends StatefulWidget{

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePageState>{
  List<String> mName = [];
  final dbHelper = DatabaseHelper.instance;
  final StreamController<List<String>> _streamController = StreamController<List<String>>();

  @override
  void initState(){
    _query();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: StreamBuilder<List<String>>(
                  stream: _streamController.stream,
                  initialData: mName,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                                child: Text(
                                    'ROW ${index + 1}: ${snapshot.data[index]}'
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
                        _insert();
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
    );;
  }

  void _insert() async {
    mName.clear();
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Thiago',
      DatabaseHelper.columnValue  : Random().nextInt(10)
    };
    await dbHelper.insert(row);
    _query();
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row){
      mName.add(row.toString() as String);
      _streamController.sink.add(mName);
      print(row);
    });
  }

  void _update() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'josef',
      DatabaseHelper.columnValue  : Random().nextInt(10)
    };
    final rowsAffected = await dbHelper.update(row);
    print('row updated $rowsAffected row(s)');
  }

  void _delete() async {
    await dbHelper.delete();
    mName.clear();
    _streamController.sink.add(mName);
  }
}
