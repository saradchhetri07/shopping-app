import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart' show Cart;

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem(this.id, this.productId, this.title, this.price, this.quantity);
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        margin: EdgeInsets.all(8.0),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 50.0,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10.0),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Are you sure?"),
                  content:
                      Text("Do you want to remove the item from the cart?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text("No")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text("yes")),
                  ],
                ));
      },
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        elevation: 15.0,
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 35.0,
              child: FittedBox(child: Text("\$${price}")),
            ),
            title: Text("${title}"),
            subtitle: Text("Total:${quantity * price}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Chip(
                  label: GestureDetector(
                      onTap: () {
                        cartProvider.addQuantitiy(productId);
                      },
                      child: Icon(Icons.add)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${quantity}"),
                ),
                Chip(
                  label: GestureDetector(
                      onTap: () {
                        cartProvider.removeQuantity(productId);
                      },
                      child: Icon(Icons.remove)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
