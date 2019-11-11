import 'package:flutter/material.dart';
import 'AppClass.dart';

void main() => runApp(AppClass());

class AppClass extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: HomePageState(),
      ),
    );
  }
}