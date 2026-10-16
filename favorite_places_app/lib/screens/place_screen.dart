import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/providers/favorite_place_provider.dart';
import 'package:favorite_places_app/screens/add_place_screen.dart';
import 'package:favorite_places_app/widgets/place_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceScreen extends ConsumerStatefulWidget {
  const PlaceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FavoritePlaceScreenState();
}

class _FavoritePlaceScreenState extends ConsumerState<PlaceScreen> {
  late Future<void> _placeFuture;

  @override
  void initState() {
    super.initState();

    _placeFuture = ref.read(favoritePlaceProvider.notifier).loadPlaces();
  }

  void _toAddScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PlaceAddScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final List<Place> userPlaces = ref.watch(favoritePlaceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [IconButton(onPressed: _toAddScreen, icon: Icon(Icons.add))],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: _placeFuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : PlaceList(places: userPlaces),
        ),
      ),
    );
  }
}
