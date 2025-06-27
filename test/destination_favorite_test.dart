import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appli/destination_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Ajout d\'un favori et persistance', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final favorites = <String>{};

    await tester.pumpWidget(
      MaterialApp(
        home: DestinationPage(
          favorites: favorites,
          onToggleFavorite: (name) {
            favorites.add(name);
            prefs.setStringList('favorites', favorites.toList());
          },
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.star_border).first);
    await tester.pump();

    expect(favorites.contains(destinations.first.name), isTrue);
    expect(prefs.getStringList('favorites'), contains(destinations.first.name));
  });
}
