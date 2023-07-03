import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(this.id, this.title, this.price, this.quantity);
  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: ListTile(
            leading: CircleAvatar(
          child: Text("hello"),
        )),
      ),
    );
  }
}
