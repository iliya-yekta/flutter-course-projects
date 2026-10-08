import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_list_app/provider/grocery_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';

const uuid = Uuid();

class NewItemScreen extends ConsumerStatefulWidget {
  const NewItemScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends ConsumerState<NewItemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';
  int _enteredQuantity = 1;
  Category _selectedCategory = categories[Categories.vegetables]!;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ref
          .read(groceryItemsProvider.notifier)
          .addGroceryItem(_enteredName, _enteredQuantity, _selectedCategory);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new Item')),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1) {
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null;
                },
                onSaved: (newValue) => _enteredName = newValue!,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: _enteredQuantity.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= -1) {
                          return 'Must be valid positive number.';
                        }
                        return null;
                      },
                      onSaved: (newValue) =>
                          _enteredQuantity = int.parse(newValue!),
                    ),
                  ),
                  const SizedBox(width: 26),
                  Expanded(
                    child: DropdownButtonFormField(
                      initialValue: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 12),
                                Text(category.value.name),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategory = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: Text('Reset'),
                  ),
                  ElevatedButton(onPressed: _saveItem, child: Text('Submit')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
