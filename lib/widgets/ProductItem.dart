import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/product.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';

import '../providers/cart.dart';

class ProductItem extends StatefulWidget {
  final String id;

  ProductItem(this.id);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  var _isint = true;

  // @override
  // void didChangeDependencies() async {
  //   // TODO: implement didChangeDependencies

  //       .isFavorite(widget.id);
  //   setState(() {
  //     _isint = false;
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Product>(context);
    final auth_data = Provider.of<Auth>(context, listen: false);

    final cart = Provider.of<Cart>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/product-detail', arguments: {
          'id': productProvider.id,
          "title": productProvider.title
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: GridTile(
          child: Hero(
            tag: productProvider.id,
            child: FadeInImage(
              placeholder: AssetImage("assets/images/product-placeholder.png"),
              image: NetworkImage(
                productProvider.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              icon: Icon(productProvider.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border_outlined),
              onPressed: () {
                productProvider.toggleFavorite(
                    auth_data.gettoken!, auth_data.getUserId!);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItem(productProvider.id, productProvider.price,
                    productProvider.title);
                //if there is snackbar currently displaying it will hide
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Added to cart",
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                      textColor: Colors.white,
                      label: "UNDO",
                      onPressed: () {
                        cart.removeItem(productProvider.id);
                      }),
                ));
              },
            ),
            title: Text(
              productProvider.title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
