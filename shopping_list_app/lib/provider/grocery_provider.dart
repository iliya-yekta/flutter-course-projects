import 'package:flutter_riverpod/legacy.dart';

import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class GroceryItemsNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryItemsNotifier() : super([]);

  void addGroceryItem(String name, int quantity, Category category) {
    state = [
      ...state,
      GroceryItem(
        id: uuid.v4(),
        name: name,
        quantity: quantity,
        category: category,
      ),
    ];
  }

  void removeGroceryItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

final groceryItemsProvider =
    StateNotifierProvider.autoDispose<GroceryItemsNotifier, List<GroceryItem>>(
      (ref) => GroceryItemsNotifier(),
    );
