import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_flutter/data/categories.dart';
import 'package:shopping_list_flutter/models/category.dart';
import 'package:shopping_list_flutter/models/grocery_item.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final randomUUID = const Uuid();

  final _formKey = GlobalKey<FormState>();

  var _enteredName = "";

  var _selectedQuantity = 1;

  var _selectedCategory = categories[Categories.vegetables]!;

  void _saveItem() async {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
    final url = Uri.https("flutter-app-shop-9f978-default-rtdb.firebaseio.com",
        "shopping-list.json");
    final postResponse = await http.post(
      url,
      headers: {
        "Content-Type": 'application/json',
      },
      body: json.encode(
        {
          "name": _enteredName,
          "quantity": _selectedQuantity,
          "category": _selectedCategory.title,
        },
      ),
    );
    final Map<String, dynamic> responseData = json.decode(postResponse.body);
    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pop(GroceryItem(
        id: responseData["name"],
        name: _enteredName,
        quantity: _selectedQuantity,
        category: _selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new Item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                validator: (userInput) {
                  if (userInput == null ||
                      userInput.isEmpty ||
                      userInput.trim().length <= 1 ||
                      userInput.trim().length > 50) {
                    return "Must be between 1 and 50 characters.";
                  }
                  return null;
                },
                onSaved: (nameValue) {
                  if (_formKey.currentState!.validate()) {
                    _enteredName = nameValue!;
                  }
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      onSaved: (quantityInput) {
                        _selectedQuantity = int.parse(quantityInput!);
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Quantity"),
                      ),
                      initialValue: _selectedQuantity.toString(),
                      validator: (userInput) {
                        if (userInput == null ||
                            userInput.isEmpty ||
                            int.tryParse(userInput) == null ||
                            int.tryParse(userInput)! <= 0) {
                          return "The quantity must be a valid positve number";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                        value: _selectedCategory,
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
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(category.value.title),
                                ],
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          _selectedCategory = value!;
                        }),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text("Reset"),
                  ),
                  ElevatedButton(
                      onPressed: _saveItem, child: const Text("Add Item"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
