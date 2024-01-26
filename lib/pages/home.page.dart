import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list_app/components/grocery_list.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/pages/new_item.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GroceryItem> _groceryItems = [];

  var _isLoading = true;

  ///First Way
  String? _error;

  ///First Way

  // late Future<List<GroceryItem>> _loadedItems;
  ///Second Way

  @override
  void initState() {
    _loadItems();

    ///First Way

    // _loadedItems = _loadItems();
    ///Second Way

    super.initState();
  }

  void _loadItems() async {
    final url = Uri.https(
      'shopping-list-7425d-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping-list.json',
    );

    ///First Way

    // Future<List<GroceryItem>> _loadItems() async {
    //   final url = Uri.https(
    //     'shopping-list-7425d-default-rtdb.europe-west1.firebasedatabase.app',
    //     'shopping-list.json',
    //   );
    ///Second Way

    try {
      ///First Way

      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later.';
        });

        ///First Way

        throw Exception(
            'Failed to fetch grocery items. Please try again later.');
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });

        /// First way

        // return [];
        ///Second way
      }
      final Map<String, dynamic> listData = await json.decode(response.body);
      final List<GroceryItem> loadedItemsList = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere((categoryItem) =>
                categoryItem.value.title == item.value['category'])
            .value;

        loadedItemsList.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }
      setState(() {
        // _groceryItems = _loadedItemsList;
        _isLoading = false;
      });

      ///First Way

      // return loadedItemsList;
      ///Second way
    } catch (error) {
      setState(() {
        _error = 'Something went wrong! Please try again later.';
      });
    }

    ///First Way
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _onRemove(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    final url = Uri.https(
      'shopping-list-7425d-default-rtdb.europe-west1.firebasedatabase.app',
      'shopping-list/${item.id}.json',
    );
    final response = await http.delete(url);

    setState(() {
      _groceryItems.remove(item);
    });

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(
          index,
          item,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = GroceryList(
      groceryItems: _groceryItems,
      onRemove: _onRemove,
    );

    ///First way

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    ///First way

    if (_groceryItems.isEmpty) {
      content = const Center(
        child: Text('You have not any shopping items yet!'),
      );
    }

    ///First way

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    ///First way

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),

      body: content,

      ///First Way

      // body:FutureBuilder(
      //   future: _loadedItems,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     if (snapshot.hasError) {
      //       return Center(
      //         child: Text(
      //           snapshot.error.toString(),
      //         ),
      //       );
      //     }
      //     if (snapshot.data!.isEmpty) {
      //       return const Center(
      //         child: Text('You have not any shopping items yet!'),
      //       );
      //     }
      //     return GroceryList(
      //       groceryItems: snapshot.data!,
      //       onRemove: _onRemove,
      //     );
      //   },
      // ),
      ///Second way
    );
  }
}
