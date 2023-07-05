import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'package:shop/widgets/app_drawer.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final productId = routeArgs["id"];
    final productTitle = routeArgs["title"];
    final loadedProduct = productsProvider.findById(productId!);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              "\$${loadedProduct.price}",
              style: TextStyle(fontSize: 30.0),
            ),
            Text(
              "${loadedProduct.description}",
              style: TextStyle(fontSize: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
