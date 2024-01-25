# Shopping list flutter app 🛒

How does this app work 🧠

First we need to know about each single screen and widget and also undestand the file structure I had developed follwing a tutorial on Udemy call  **"Flutter & Dart - The Complete Guide"** by the instrucotr   [Maximilian Schwarzmüller](https://www.udemy.com/user/maximilian-schwarzmuller/).



## File Strcutre - Screen and Widgets 📑 

On the lib folder I created 3 new folders in order to separete the functionallity and data models ⚙️ 🧠. 


- Data folder
    this folder contains all the data that our app will work with 
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
    - dummy_items.dart
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


