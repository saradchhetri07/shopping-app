import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/widgets/ProductItem.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../providers/products.dart';
import '../widgets/productGrid.dart';
import 'package:shop/widgets/app_drawer.dart';

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

enum FavoritesOptions { favorites, all }

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  var _showOnlyFavorite = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My shop'),
        actions: [
          PopupMenuButton(
              onSelected: (FavoritesOptions selectedValue) {
                if (selectedValue == FavoritesOptions.favorites) {
                  setState(() {
                    _showOnlyFavorite = true;
                    print("from setstate ${_showOnlyFavorite}");
                  });
                } else {
                  setState(() {
                    _showOnlyFavorite = false;
                  });
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text("favorites"),
                      value: FavoritesOptions.favorites,
                    ),
                    const PopupMenuItem(
                      child: Text("all"),
                      value: FavoritesOptions.all,
                    )
                  ]),
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 15.0),
            child: Consumer<Cart>(
                builder: (_, cart, child) => badges.Badge(
                      badgeContent: Text('${cart.ItemCounts}'),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/cart');
                          },
                          child: const Icon(Icons.shopping_cart)),
                    )),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: productGrid(_showOnlyFavorite),
    );
  }
}
