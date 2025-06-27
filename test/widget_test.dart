import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appli/main.dart';

void main() {
  testWidgets('Navigation via la barre du bas', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Page par défaut : leçon
    expect(find.widgetWithText(AppBar, 'Leçon'), findsOneWidget);

    // Aller vers Destinations
    await tester.tap(find.text('Destinations'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Destinations'), findsOneWidget);

    // Aller vers Données
    await tester.tap(find.text('Données'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'Données publiques'), findsOneWidget);
  });
}
