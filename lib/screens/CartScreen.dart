import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart' show Cart;
import 'package:shop/widgets/CartItem.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: [
          Card(
            elevation: 10.0,
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 28.0),
                  ),
                  Row(
                    children: [
                      Chip(
                        label: Text(
                          "\$ ${cartProvider.getTotal}",
                          style: TextStyle(fontSize: 28.0),
                        ),
                      ),
                      TextButton(onPressed: () {}, child: Text("order now"))
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: cartProvider.ItemCounts,
                          itemBuilder: (ctx, i) => CartItem(
                              cartProvider.items[i]!.id,
                              cartProvider.items[i]!.title,
                              cartProvider.items[i]!.price,
                              cartProvider.items[i]!.quantity)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
