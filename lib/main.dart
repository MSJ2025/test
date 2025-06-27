import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Set<String> _favorites = <String>{};

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('darkMode') ?? false;
    final favList = prefs.getStringList('favorites') ?? <String>[];
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      _favorites = favList.toSet();
    });
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _themeMode == ThemeMode.dark);
    await prefs.setStringList('favorites', _favorites.toList());
  }

  void _toggleTheme(bool value) {
    setState(() {
      _themeMode = value ? ThemeMode.dark : ThemeMode.light;
    });
    _savePrefs();
  }

  void _toggleFavorite(String name) {
    setState(() {
      if (_favorites.contains(name)) {
        _favorites.remove(name);
      } else {
        _favorites.add(name);
      }
    });
    _savePrefs();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corsican Lingo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF58CC02)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: HomePage(
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
        favorites: _favorites,
        onToggleFavorite: _toggleFavorite,
      ),
    );
  }
}
