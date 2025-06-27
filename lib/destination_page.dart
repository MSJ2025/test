import 'package:flutter/material.dart';

class Destination {
  final String name;
  final String description;

  const Destination(this.name, this.description);
}

const List<Destination> destinations = [
  Destination('Ajaccio',
      'Capitale de la Corse du Sud, connue pour sa vieille ville et sa cathédrale.'),
  Destination('Bonifacio',
      'Ville perchée sur des falaises de calcaire blanc offrant un panorama exceptionnel.'),
  Destination('Calvi',
      'Port de plaisance réputé pour sa citadelle génoise et ses plages.'),
];

class DestinationPage extends StatelessWidget {
  const DestinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guide de la Corse')),
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final dest = destinations[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(dest.name),
              subtitle: Text(dest.description),
            ),
          );
        },
      ),
    );
  }
}
