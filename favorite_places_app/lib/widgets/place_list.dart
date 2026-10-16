import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/widgets/place_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceList extends ConsumerStatefulWidget {
  const PlaceList({super.key, required this.places});

  final List<Place> places;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlaceListState();
}

class _PlaceListState extends ConsumerState<PlaceList> {
  @override
  Widget build(BuildContext context) {
    final favoritePlaceList = widget.places;

    if (favoritePlaceList.isEmpty) {
      return Center(
        child: Text(
          'No places added yet...',
          style: Theme.of(context).textTheme.bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    }

    return ListView.builder(
      itemCount: favoritePlaceList.length,
      itemBuilder: (context, index) =>
          FavoritePlaceItem(favoritePlace: favoritePlaceList[index]),
    );
  }
}
