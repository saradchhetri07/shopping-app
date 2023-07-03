import 'package:flutter/material.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/CartScreen.dart';
import 'package:shop/screens/product_details.dart';
import 'package:shop/screens/product_overview_screen.dart';
import 'package:shop/providers/cart.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (ctx) => Cart())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Shop',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen()
        },
      ),
    );
  }
}
