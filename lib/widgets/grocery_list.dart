import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shopping_list_flutter/data/categories.dart';
import 'package:shopping_list_flutter/models/grocery_item.dart';
import 'package:shopping_list_flutter/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  List<GroceryItem> _groceryItems = [];
  var isLoading = true;
  String? _error;

  void _loadItems() async {
    final url = Uri.https("flutter-app-shop-9f978-default-rtdb.firebaseio.com");

    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to load data. Please try again later';
        });
      }
      if (response.body == "null") {
        setState(() {
          isLoading = false;
        });
        return;
      }
      final List<GroceryItem> loadedItemList = [];
      final Map<String, dynamic> listData = json.decode(response.body);
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere((categoryItem) =>
                categoryItem.value.title == item.value["category"])
            .value;
        loadedItemList.add(
          GroceryItem(
              id: item.key,
              name: item.value['name'],
              quantity: item.value['quantity'],
              category: category),
        );
      }
      setState(() {
        _groceryItems = loadedItemList;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = "Something went wrong";
      });
    }
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https("flutter-app-shop-9f978-default-rtdb.firebaseio.com",
        "shopping-list/${item.id}.json");
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Item could not deleted"),
        ),
      );
      setState(() {
        _groceryItems.insert(index, item);
      });
    } else {
      if (!context.mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${item.name}" was deleted'),
        ),
      );
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget itemList = ListView.builder(
      itemCount: _groceryItems.length,
      itemBuilder: (context, index) => Dismissible(
        key: Key(_groceryItems[index].id),
        onDismissed: (direction) {
          _removeItem(_groceryItems[index]);
        },
        child: ListTile(
          title: Text(_groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: _groceryItems[index].category.color,
          ),
          trailing: Text(
            _groceryItems[index].quantity.toString(),
          ),
        ),
      ),
    );

    final Widget noItemList = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_shopping_cart_sharp,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(
            height: 18,
          ),
          Text("The list is empty",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 25)),
          const SizedBox(
            height: 18,
          ),
          Text("The current list is empty, try adding a new item",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w400))
        ],
      ),
    );

    Widget isLoadingWidget = const Center(
      child: CircularProgressIndicator(),
    );

    Widget widgetController() {
      if (_error != null) {
        return Center(
          child: Text(_error!),
        );
      }
      if (isLoading) {
        return isLoadingWidget;
      }
      if (_groceryItems.isEmpty) {
        return noItemList;
      }
      return itemList;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My grocery list"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: widgetController(),
    );
  }
}
