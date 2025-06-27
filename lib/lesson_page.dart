import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class Lesson {
  final String question;
  final List<String> options;
  final String answer;

  Lesson({required this.question, required this.options, required this.answer});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List<dynamic>),
      answer: json['answer'] as String,
    );
  }
}

class _LessonPageState extends State<LessonPage> {
  late Future<List<Lesson>> _lessonsFuture;
  int _currentIndex = 0;
  String? selected;
  late List<Lesson> _loadedLessons;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _lessonsFuture = _loadLessons();
    _loadProgress();
  }

  Future<List<Lesson>> _loadLessons() async {
    final data = await rootBundle.loadString('assets/lessons.json');
    final jsonMap = jsonDecode(data) as Map<String, dynamic>;
    final list = jsonMap['lessons'] as List<dynamic>;
    return list.map((e) => Lesson.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> _loadProgress() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentIndex = _prefs?.getInt('lesson_index') ?? 0;
    });
  }

  void _select(String value) {
    setState(() {
      selected = value;
    });
    final isCorrect = value == _loadedLessons[_currentIndex].answer;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(isCorrect ? 'Correct !' : 'Incorrect')),
    );
    if (isCorrect) {
      _currentIndex = (_currentIndex + 1).clamp(0, _loadedLessons.length - 1);
      _prefs?.setInt('lesson_index', _currentIndex);
      setState(() {
        selected = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leçon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Lesson>>(
          future: _lessonsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else {
              _loadedLessons = snapshot.data!;
              _currentIndex = _currentIndex.clamp(0, _loadedLessons.length - 1);
              final lesson = _loadedLessons[_currentIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearProgressIndicator(
                    value: _currentIndex / _loadedLessons.length,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    lesson.question,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  for (final option in lesson.options)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        onPressed: () => _select(option),
                        child: Text(option),
                      ),
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
