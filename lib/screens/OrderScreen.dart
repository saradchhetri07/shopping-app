import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop/providers/orders.dart' show Order;
import 'package:provider/provider.dart';
import 'package:shop/widgets/OrderItem.dart';
import 'package:shop/widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/orders";
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Order>(context);
    print("total order ${orderProvider.orders.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Ordered Items"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
          itemCount: orderProvider.orders.length,
          itemBuilder: (ctx, i) => OrderItem(orderProvider.orders[i])),
    );
  }
}
