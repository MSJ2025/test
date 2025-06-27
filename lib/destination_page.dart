import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_page.dart';

class Destination {
  final String name;
  final String description;
  final double lat;
  final double lng;
  final String imageUrl;

  const Destination(
    this.name,
    this.description,
    this.lat,
    this.lng,
    this.imageUrl,
  );
}

const List<Destination> destinations = [
  Destination(
    'Ajaccio',
    'Capitale de la Corse du Sud, connue pour sa vieille ville et sa cathédrale.',
    41.919229,
    8.738635,
    'https://upload.wikimedia.org/wikipedia/commons/8/80/Ajaccio_vue.jpg',
  ),
  Destination(
    'Bonifacio',
    'Ville perchée sur des falaises de calcaire blanc offrant un panorama exceptionnel.',
    41.3879,
    9.159,
    'https://upload.wikimedia.org/wikipedia/commons/b/b2/Bonifacio_haut.jpg',
  ),
  Destination(
    'Calvi',
    'Port de plaisance réputé pour sa citadelle génoise et ses plages.',
    42.559,
    8.758,
    'https://upload.wikimedia.org/wikipedia/commons/5/5f/Calvi_vue.jpg',
  ),
];

class DestinationPage extends StatefulWidget {
  final Set<String> favorites;
  final ValueChanged<String> onToggleFavorite;

  const DestinationPage({
    required this.favorites,
    required this.onToggleFavorite,
    super.key,
  });

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  bool _showOnlyFavorites = false;

  void _openMap(BuildContext context, Destination dest) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MapPage(
          position: LatLng(dest.lat, dest.lng),
          title: dest.name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _showOnlyFavorites
        ? destinations.where((d) => widget.favorites.contains(d.name)).toList()
        : destinations;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Destinations'),
        actions: [
          IconButton(
            icon: Icon(
              _showOnlyFavorites ? Icons.star : Icons.star_border,
            ),
            onPressed: () {
              setState(() {
                _showOnlyFavorites = !_showOnlyFavorites;
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final dest = items[index];
          final isFav = widget.favorites.contains(dest.name);
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(dest.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(dest.name),
              subtitle: Text(dest.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(isFav ? Icons.star : Icons.star_border, color: Colors.amber),
                    onPressed: () => widget.onToggleFavorite(dest.name),
                  ),
                  IconButton(
                    icon: const Icon(Icons.map),
                    onPressed: () => _openMap(context, dest),
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
