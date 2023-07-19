import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop/providers/orders.dart' show Order;
import 'package:provider/provider.dart';
import 'package:shop/widgets/OrderItem.dart';
import 'package:shop/widgets/app_drawer.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "/orders";
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero).then((_) async {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   await Provider.of<Order>(context, listen: false).FetchAndSetOrders();
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Order>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Ordered Items"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future:
                Provider.of<Order>(context, listen: false).FetchAndSetOrders(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (dataSnapshot.error != null) {
                return Center(
                  child: Text("error occured"),
                );
              }
              return ListView.builder(
                  itemCount: orderProvider.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderProvider.orders[i]));
              // return Consumer<Order>(
              //     builder: (ctx, orderData, child) => ListView.builder(
              //         itemCount: orderProvider.orders.length,
              //         itemBuilder: (ctx, i) => OrderItem(orderData.orders[i])));
            }));
  }
}
