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

    Widget activeWidget = groceryItems.when(
      data: (items) {
        if (items.isEmpty) {
          return Center(child: Text('No grocery item. Add new one...'));
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => Dismissible(
            key: ValueKey(items[index].id),
            onDismissed: (direction) async => await ref
                .read(groceryItemsProvider.notifier)
                .removeGroceryItem(items[index].id),
            background: Container(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: ShoppingItem(groceryItem: items[index]),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {

        return Center(
          child: Text(
            'Faild to featch data. Please try again later',
          ),
        );
      },
    );

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
