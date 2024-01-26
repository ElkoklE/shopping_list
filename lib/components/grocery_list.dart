import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  final List<GroceryItem> groceryItems;
  final void Function(GroceryItem item) onRemove;

  const GroceryList(
      {Key? key, required this.groceryItems, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (context, index) => Dismissible(
        background: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.delete),
            ),
          ),
        ),
        key: ValueKey(
          groceryItems[index].id,
        ),
        onDismissed: (direction) {
          onRemove(
            groceryItems[index],
          );
        },
        child: ListTile(
          title: Text(groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[index].category.color,
          ),
          trailing: Text(
            groceryItems[index].quantity.toString(),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
