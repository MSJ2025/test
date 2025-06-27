import 'package:flutter/material.dart';
import 'destination_page.dart';
import 'data_page.dart';

class HomePage extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<bool> onToggleTheme;
  final Set<String> favorites;
  final ValueChanged<String> onToggleFavorite;

  const HomePage({
    required this.themeMode,
    required this.onToggleTheme,
    required this.favorites,
    required this.onToggleFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide Corse'),
        actions: [
          Row(
            children: [
              const Icon(Icons.dark_mode),
              Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: onToggleTheme,
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Découvrez les plus belles destinations de Corse',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DestinationPage(
                      favorites: favorites,
                      onToggleFavorite: onToggleFavorite,
                    ),
                  ),
                );
              },
              child: const Text('Voir les destinations'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const DataPage(),
                  ),
                );
              },
              child: const Text('Explorer les données publiques'),
            ),
          ],
        ),
      ),
    );
  }
}
