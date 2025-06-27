import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appli/main.dart';

void main() {
  testWidgets('BottomNavigationBar affiche les onglets', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Vérifie la présence du BottomNavigationBar
    final barFinder = find.byType(BottomNavigationBar);
    expect(barFinder, findsOneWidget);

    final bar = tester.widget<BottomNavigationBar>(barFinder);
    final labels = bar.items.map((item) => item.label).toList();

    expect(labels, contains('Accueil'));
    expect(labels, contains('Destinations'));
    expect(labels, contains('Données'));
  });
}
