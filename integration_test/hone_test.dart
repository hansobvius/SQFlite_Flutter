import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_sqflite_example/Main.dart' as app;

void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('SQFLIE_HOME_TEST' , () {
    
    setUp(() {});
    
    testWidgets('insert text', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      var insertButton = find.byKey(const Key('INSERT_KEY'));
      expect(insertButton, findsOneWidget, reason: 'Check if insert button was founded');

      var deleteButton = find.byKey(const Key('DELETE_KEY'));
      expect(deleteButton, findsOneWidget, reason: 'Check if delete button was founded');
    });
    
    tearDown(() {});
  });
}