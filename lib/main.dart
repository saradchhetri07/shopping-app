import 'package:flutter/material.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/CartScreen.dart';
import 'package:shop/screens/OrderScreen.dart';
import 'package:shop/screens/product_details.dart';
import 'package:shop/screens/product_overview_screen.dart';
import 'package:shop/providers/cart.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Order()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrderScreen.routeName: (context) => OrderScreen()
        },
      ),
    );
  }
}
