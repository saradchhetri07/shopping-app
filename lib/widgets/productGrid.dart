import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import '../providers/products.dart';
import 'ProductItem.dart';

class productGrid extends StatefulWidget {
  final bool showFavs;
  productGrid(this.showFavs);

  @override
  State<productGrid> createState() => _productGridState();
}

class _productGridState extends State<productGrid> {
  @override
  Widget build(BuildContext context) {
    //adding listener for the products
    print("in product grid ${widget.showFavs}");
    final productsProvider = Provider.of<Products>(context);
    final products = widget.showFavs
        ? productsProvider.getFavItems
        : productsProvider.getItems;
    print(widget.showFavs);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        builder: (context, child) {
          return ProductItem();
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20.0),
    );
  }
}
