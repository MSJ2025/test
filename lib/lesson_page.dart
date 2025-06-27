import 'package:flutter/material.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final String question = 'Comment dit-on "bonjour" en corse ?';
  final List<String> options = ['Bonghjornu', 'Salute', 'Ciao'];
  final String correctAnswer = 'Bonghjornu';
  String? selected;

  void _select(String value) {
    setState(() {
      selected = value;
    });
    final isCorrect = value == correctAnswer;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isCorrect ? 'Correct !' : 'Incorrect')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leçon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            for (final option in options)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => _select(option),
                  child: Text(option),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
