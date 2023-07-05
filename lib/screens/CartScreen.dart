import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart' show Cart;
import 'package:shop/widgets/CartItem.dart';
import 'package:shop/providers/orders.dart';

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
                          "\$ ${cartProvider.getTotal.ceil()}",
                          style: TextStyle(fontSize: 28.0),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Provider.of<Order>(context, listen: false).addOrder(
                                cartProvider.getCartItems(),
                                cartProvider.getTotal);
                            cartProvider.clearItem();
                          },
                          child: Text("order now"))
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cartProvider.ItemCounts,
                  itemBuilder: (ctx, i) => CartItem(
                      cartProvider.items.values.toList()[i].id,
                      cartProvider.items.keys.toList()[i],
                      cartProvider.items.values.toList()[i].title,
                      cartProvider.items.values.toList()[i].price,
                      cartProvider.items.values.toList()[i].quantity)))
        ],
      ),
    );
  }
}
