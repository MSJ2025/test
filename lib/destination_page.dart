import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Destination {
  final String name;
  final String description;
  final double lat;
  final double lng;

  const Destination(this.name, this.description, this.lat, this.lng);
}

const List<Destination> destinations = [
  Destination('Ajaccio', 'Capitale de la Corse du Sud, connue pour sa vieille ville et sa cathédrale.', 41.919229, 8.738635),
  Destination('Bonifacio', 'Ville perchée sur des falaises de calcaire blanc offrant un panorama exceptionnel.', 41.3879, 9.159),
  Destination('Calvi', 'Port de plaisance réputé pour sa citadelle génoise et ses plages.', 42.559, 8.758),
];

class DestinationPage extends StatelessWidget {
  final Set<String> favorites;
  final ValueChanged<String> onToggleFavorite;

  const DestinationPage({
    required this.favorites,
    required this.onToggleFavorite,
    super.key,
  });

  Future<void> _openMap(double lat, double lng) async {
    final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=\$lat,\$lng');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Destinations')),
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final dest = destinations[index];
          final isFav = favorites.contains(dest.name);
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(dest.name),
              subtitle: Text(dest.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(isFav ? Icons.star : Icons.star_border, color: Colors.amber),
                    onPressed: () => onToggleFavorite(dest.name),
                  ),
                  IconButton(
                    icon: const Icon(Icons.map),
                    onPressed: () => _openMap(dest.lat, dest.lng),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
