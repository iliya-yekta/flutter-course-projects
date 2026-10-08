import 'package:flutter/material.dart';

import 'package:shopping_list_app/models/grocery_item.dart';

class ShoppingItem extends StatelessWidget {
  const ShoppingItem({super.key, required this.groceryItem});

  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(groceryItem.name),
        leading: Container(
          width: 24,
          height: 24,
          color: groceryItem.category.color,
        ),
        trailing: Text(
          groceryItem.quantity.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
