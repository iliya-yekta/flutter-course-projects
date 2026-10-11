import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/data/categories.dart';

import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

const databaseHost = "";

class GroceryItemsNotifier extends AsyncNotifier<List<GroceryItem>> {
  @override
  FutureOr<List<GroceryItem>> build() async {
    final List<GroceryItem> listData = [];
    final url = Uri.https(databaseHost, 'shopping-list.json');
    final response = await http.get(url);

    if (response.body != 'null') {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      for (final item in jsonData.entries) {
        listData.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: categories.entries
                .firstWhere(
                  (catItem) => catItem.value.name == item.value['category'],
                )
                .value,
          ),
        );
      }
    }
    return listData;
  }

  Future<void> addGroceryItem(
    String name,
    int quantity,
    Category category,
  ) async {
    final url = Uri.https(databaseHost, 'shopping-list.json');

    await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'quantity': quantity,
        'category': category.name,
      }),
    );

    state = AsyncData([
      ...?state.value,
      GroceryItem(name: name, quantity: quantity, category: category),
    ]);
  }

  Future<void> removeGroceryItem(String id) async {
    final url = Uri.https(databaseHost, 'shopping-list/$id.json');

    await http.delete(url);

    state = AsyncData([...state.value!.where((item) => item.id != id)]);
  }
}

final groceryItemsProvider =
    AsyncNotifierProvider.autoDispose<GroceryItemsNotifier, List<GroceryItem>>(
      GroceryItemsNotifier.new,
    );
