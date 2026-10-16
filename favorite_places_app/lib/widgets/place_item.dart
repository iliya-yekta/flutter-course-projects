import 'package:favorite_places_app/models/place.dart';
import 'package:favorite_places_app/screens/detail_place_screen.dart';
import 'package:flutter/material.dart';

class FavoritePlaceItem extends StatelessWidget {
  const FavoritePlaceItem({super.key, required this.favoritePlace});

  final Place favoritePlace;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 26,
        backgroundImage: FileImage(favoritePlace.image),
      ),
      title: Text(
        favoritePlace.title,
        style: Theme.of(context).textTheme.bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      subtitle: Text(
        favoritePlace.location.address,
        style: Theme.of(context).textTheme.bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlaceDetailScreen(favoritePlace: favoritePlace),
        ),
      ),
    );
  }
}
