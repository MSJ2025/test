import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appli/main.dart';

void main() {
  testWidgets('Home page shows welcome text', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Commencez votre apprentissage du corse'), findsOneWidget);
    expect(find.text('Commencer les leçons'), findsOneWidget);
  });
}
