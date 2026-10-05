import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/models/meal.dart';

class FavoriteProviderNotifier extends StateNotifier<List<Meal>> {
  FavoriteProviderNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final isMealFavorite = state.contains(meal);

    if (isMealFavorite) {
      state = state.where((mealState) => mealState.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteProviderNotifier, List<Meal>>((ref) {
      return FavoriteProviderNotifier();
    });
