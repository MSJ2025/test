import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final LatLng position;
  final String title;

  const MapPage({required this.position, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: position, zoom: 12),
        markers: {
          Marker(
            markerId: const MarkerId('dest'),
            position: position,
            infoWindow: InfoWindow(title: title),
          ),
        },
      ),
    );
  }
}
