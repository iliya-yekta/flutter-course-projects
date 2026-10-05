import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meals_app/provider/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersrNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersrNotifier()
    : super({
        Filter.glutenFree: false,
        Filter.lactoseFree: false,
        Filter.vegetarian: false,
        Filter.vegan: false,
      });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersrNotifier, Map<Filter, bool>>(
      (ref) => FiltersrNotifier(),
    );

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filteredMeals = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (filteredMeals[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filteredMeals[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filteredMeals[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (filteredMeals[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
