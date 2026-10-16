import 'dart:io';

import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/providers/favorite_place_provider.dart';
import 'package:favorite_places_app/widgets/image.input.dart';
import 'package:favorite_places_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceAddScreen extends ConsumerStatefulWidget {
  const PlaceAddScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FavoritePlaceAddScreenState();
}

class _FavoritePlaceAddScreenState extends ConsumerState<PlaceAddScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  void _onSelectedImage(File image) {
    _selectedImage = image;
  }

  void _onSelectedLocation(PlaceLocation location) {
    _selectedLocation = location;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _titleController.text.trim() == '' ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }

    {
      ref
          .read(favoritePlaceProvider.notifier)
          .addFavoritePlace(_titleController.text, _selectedImage!, _selectedLocation!);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Favorite Place')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            const SizedBox(height: 20),
            ImageInput(onSelectedImage: _onSelectedImage),
            const SizedBox(height: 20),
            LocationInput(onSelectedLocation: _onSelectedLocation),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _savePlace,
              label: const Text('Add Place'),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
