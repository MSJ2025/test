import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appli/lesson_page.dart';

void main() {
  testWidgets('Sélection de la bonne réponse affiche Correct !', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LessonPage()));
    await tester.pumpAndSettle();

    const bonneReponse = 'Bonghjornu';
    final correctFinder = find.widgetWithText(ElevatedButton, bonneReponse);
    await tester.tap(correctFinder);
    await tester.pump();

    expect(find.text('Correct !'), findsOneWidget);
  });
}
