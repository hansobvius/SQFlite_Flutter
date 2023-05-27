import "package:flutter/material.dart";
import 'di/ServiceLocator.dart';
import 'ui/home.dart';

class Application extends StatelessWidget{

  final ServiceLocator serviceLocator;

  Application({required this.serviceLocator});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(serviceLocator: serviceLocator,),
    );
  }
}