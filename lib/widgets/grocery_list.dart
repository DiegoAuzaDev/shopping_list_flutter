import 'package:flutter/material.dart';
import 'package:shopping_list_flutter/models/grocery_item.dart';
import 'package:shopping_list_flutter/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groveryItems = [];
  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(builder: (ctx) => const NewItem()));
    if (newItem == null) {
      return;
    }
    setState(() {
      _groveryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget itemList = ListView.builder(
      itemCount: _groveryItems.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(_groveryItems[index].name),
        leading: Container(
          width: 24,
          height: 24,
          color: _groveryItems[index].category.color,
        ),
        trailing: Text(
          _groveryItems[index].quantity.toString(),
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

    Widget widgetController() {
      if (_groveryItems.isEmpty) {
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
