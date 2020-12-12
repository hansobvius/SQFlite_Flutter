import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/app/di/ServiceLocator.dart';
import 'app/Application.dart';

void main(){
  final ServiceLocator serviceLocator = ServiceLocator();
  runApp(Application(serviceLocator: serviceLocator,));
}

