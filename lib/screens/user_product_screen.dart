import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop/providers/products.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shop/widgets/userProduct.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/userProduct";
  const UserProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your product"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/editProduct');
                },
                child: Icon(Icons.add)),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: productProvider.getItems.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              userProductWidget(
                  productProvider.getItems[i].id,
                  productProvider.getItems[i].title,
                  productProvider.getItems[i].imageUrl),
              const Divider()
            ],
          ),
        ),
      ),
    );
  }
}
