import 'package:favorite_places_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.placeLocation = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation placeLocation;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? 'Pick your location' : 'Your location',
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedPosition);
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
            widget.placeLocation.latitude,
            widget.placeLocation.longitude,
          ),
          initialZoom: 16,
          onTap: !widget.isSelecting
              ? null
              : (tapPosition, point) => setState(() {
                  _pickedPosition = point;
                }),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.hikaru.favorite_places_app',
          ),
          MarkerLayer(
            markers: (_pickedPosition == null && widget.isSelecting)
                ? []
                : [
                    Marker(
                      point:
                          _pickedPosition ??
                          LatLng(
                            widget.placeLocation.latitude,
                            widget.placeLocation.longitude,
                          ),
                      width: 80,
                      height: 80,
                      child: Icon(Icons.location_pin),
                    ),
                  ],
          ),
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution('© OpenStreetMap contributors'),
            ],
          ),
        ],
      ),
    );
  }
}
