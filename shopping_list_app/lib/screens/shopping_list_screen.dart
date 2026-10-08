import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/provider/grocery_provider.dart';
import 'package:shopping_list_app/screens/new_item_screen.dart';
import 'package:shopping_list_app/widgets/shopping_item.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShoppingListScreenState();
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen> {
  void _toAddItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewItemScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groceryItems = ref.watch(groceryItemsProvider);
    final groceryItemsNotifier = ref.watch(groceryItemsProvider.notifier);

    Widget activeWidget = Center(
      child: Text('No grocery item. Add new one...'),
    );

    if (groceryItems.isNotEmpty) {
      activeWidget = ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(groceryItems[index].id),
          onDismissed: (direction) =>
              groceryItemsNotifier.removeGroceryItem(groceryItems[index].id),
          background: Container(color: Theme.of(context).colorScheme.onPrimary),
          child: ShoppingItem(groceryItem: groceryItems[index]),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your groceries'),
        actions: [
          IconButton(
            onPressed: () => _toAddItem(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: activeWidget,
    );
  }
}
