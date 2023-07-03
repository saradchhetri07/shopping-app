import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop/providers/product.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/product-detail',
            arguments: {'id': product.id, "title": product.title});
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              icon: Icon(product.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined),
              onPressed: () {
                product.toggleFavorite();
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
              },
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
