# Shopping list flutter app 🛒

How does this app work 🧠

First we need to know about each single screen and widget and also undestand the file structure I had developed follwing a tutorial on Udemy call  **"Flutter & Dart - The Complete Guide"** by the instrucotr   [Maximilian Schwarzmüller](https://www.udemy.com/user/maximilian-schwarzmuller/).



## File Strcutre - Screen and Widgets 📑 

On the lib folder I created 3 new folders in order to separete the functionallity and data models ⚙️ 🧠. 


- data folder
    - categorie.dart 🎯
    ```
    const categories = {
    Categories.vegetables: Category(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
    ),
    ...
    }
    ```
    - dummy_items.dart 🎯
    ```
    final groceryItems = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categories[Categories.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[Categories.meat]!),
    ];
    ```
- models 
    - category.dart 🎯

    This enum allowed me to assign predefined values, this case I need to assingme some predefined categories such as vegetable, fruit, meat, dairy and so on.

    ```
    enum Categories {
    vegetables,
    fruit,
    meat,
    dairy,
    carbs,
    sweets,
    spices,
    convenience,
    hygiene,
    other,
    }   
    ```

    - grocery_item.dart 🎯


## Context Navigatio 

How does the navigation work?

first we need to identify the state we are currently extending in our class, if we are extending  statelesWidget we must pass **context** into out Navigator but if we are extending statefulWidget we do not need to pass any context becase this state already provived it. 

- Navigation method - **StatelesWidget**

    ```
    void _navigationControler(BuildContext context){
        Navigator.of(context).push(MaterialPageRoute(builder : (cnt) => const ScreenToNavigate()));
    }
    ```

 - Navigation method - **StatefulWidget**

    ```
     void _navigationControler(){
        Navigator.of(context).push(MaterialPageRoute(builder : (cnt) => const ScreenToNavigate()));
    }
    ```

## Flutter funionallity 

### How pass data using pop and push between widgets 

**Pass Data using pop()**
first we need to need to let dart know that we want to pass data pack to the widget that push the current widget 
- How to pass data back ? 
    ```
    Navigator.of(conext).pop(ItemType(
        id : itemID 
        name : itemName
        ...
    ))
    ```
- How to get the the data ? 
    ```
    // first we need to save the data is getting pass in a variable 
    final newItemPass = Navigaor.of(context).push<ItemType>(ItemType( id : itemID name : itemName...))
    ```

## Pub Package : 

- http 1.2.0
    This package contains a set of high-level functions and classes that make it easy to consume HTTp resources. it is multi-platform (mobile, desktop, and browser) and support multiple implementations.
    **Installing**
    ```
    flutter pub add http
    ```


- uuid 4.4.4 
    This package allowed the developer to create IDs. 

    How to install it and how to use it ?

    full documentation here - [uuid](https://pub.dev/packages/uuid/install)

    **Installing**
    ```
    flutter pub add uuid
    ```
    **Import it**
    ```
    import 'package:uuid/uuid.dart';
    ```
    **Use it**
    ```
    Generate a v1 (time-based) id

    uuid.v1(); // ->    '6c84fb90-12c4-11e1-840d-7b25c5ee775a'

    // Generate a v4 (random) id
    uuid.v4(); // ->    '110ec58a-a0f2-4ac4-8393-c866d813b8d1'

    Generate a v5 (namespace-name-sha1-based) 
    id uuid.v5(Uuid.NAMESPACE_URL, 'www.google.com'); // ->   'c74a196f-f19d-5ea9-bffd-a2742432fc9c'
    ```
