import 'package:flutter/material.dart';
import 'lesson_page.dart';

class HomePage extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<bool> onToggleTheme;
  const HomePage({
    required this.themeMode,
    required this.onToggleTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cours de Corse'),
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
            Text(
              'Commencez votre apprentissage du corse',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF58CC02),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const LessonPage(),
                  ),
                );
              },
              child: const Text('Commencer les leçons'),
            ),
          ],
        ),
      ),
    );
  }
}
