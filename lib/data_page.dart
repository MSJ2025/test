import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  Future<List<String>> _fetchData() async {
    final response = await http.get(
      Uri.parse('https://www.data.corsica/api/records/1.0/search/?dataset=lieux-culturels&rows=10'),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final records = json['records'] as List<dynamic>;
      return records
          .map((e) => e['fields']['nom']?.toString() ?? 'Inconnu')
          .toList();
    }
    throw Exception('Erreur lors du chargement');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Données publiques')),
      body: FutureBuilder<List<String>>(
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final items = snapshot.data ?? [];
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(items[index]));
              },
            );
          }
        },
      ),
    );
  }
}
