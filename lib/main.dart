import 'package:flutter/material.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/screens/CartScreen.dart';
import 'package:shop/screens/OrderScreen.dart';
import 'package:shop/screens/edit_product.dart';
import 'package:shop/screens/product_details.dart';
import 'package:shop/screens/product_overview_screen.dart';
import 'package:shop/providers/cart.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/screens/user_product_screen.dart';
import 'package:shop/screens/264 auth_screen.dart';
import 'package:shop/screens/277 splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
              create: (ctx) => Products(null, [], null),
              update: (ctx, auth, previousProducts) => Products(
                  auth.gettoken,
                  previousProducts == null ? [] : previousProducts.getItems,
                  auth.getUserId)),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProxyProvider<Auth, Order>(
              create: (ctx) => Order(null, null, []),
              update: (ctx, auth, previousOrders) => Order(
                  auth.gettoken,
                  auth.getUserId,
                  previousOrders == null ? [] : previousOrders.orders)),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My Shop',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              hintColor: Colors.redAccent,
              fontFamily: 'Montserrat',
              textTheme: ThemeData.light().textTheme.copyWith(
                    bodyText1: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    headline4: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    headline6: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    headline1: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 80,
                    ),
                  ),
            ),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogIn(),
                    builder: (ctx, authsnapshot) =>
                        authsnapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrderScreen.routeName: (context) => OrderScreen(),
              UserProductScreen.routeName: (context) => UserProductScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen()
            },
          ),
        ));
  }
}
