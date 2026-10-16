import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

//! Your api key
const apiKey = '';

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;

  String get locationImage {
    return 'https://maps.geoapify.com/v1/staticmap?style=osm-bright-smooth&width=600&height=400&center=lonlat%3A$longitude%2C$latitude&zoom=18&marker=lonlat%3A$longitude%2C$latitude%3Btype%3Aawesome%3Bcolor%3A%23bb3f73%3Bsize%3Ax-large&apiKey=$apiKey';
  }
}

class Place {
  Place({
    required this.title,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
