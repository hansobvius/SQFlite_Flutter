import 'package:flutter/material.dart';
import 'package:flutter_sqflite_example/app/di/ServiceLocator.dart';
import 'app/Application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ServiceLocator serviceLocator = ServiceLocator();
  runApp(Application(serviceLocator: serviceLocator));
}

