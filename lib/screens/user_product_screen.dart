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

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productProvider = Provider.of<Products>(context);

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
      body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, datasnapshot) =>
              // if (datasnapshot.connectionState == ConnectionState.waiting) {
              //   return Center(child: CircularProgressIndicator());
              // } else if (datasnapshot.hasError != null) {
              //   return Center(child: Text("error retrieving data"));
              // }
              datasnapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => _refreshProducts(context),
                      child: Consumer<Products>(
                        builder: (ctx, productProvider, _) => ListView.builder(
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
                      ),
                    )),
    );
  }
}
