import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop/providers/products.dart';
import "package:provider/provider.dart";

class userProductWidget extends StatefulWidget {
  final String productId;
  final String productTitle;
  final String imageURL;

  userProductWidget(this.productId, this.productTitle, this.imageURL);

  @override
  State<userProductWidget> createState() => _userProductWidgetState();
}

class _userProductWidgetState extends State<userProductWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(widget.imageURL)),
      title: Text("${widget.productTitle}"),
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/editProduct",
                  arguments: widget.productId);
            },
            child: Icon(
              Icons.edit,
              color: Colors.green,
            ),
          ),
          SizedBox(width: 15.0),
          GestureDetector(
            onTap: () {
              Provider.of<Products>(context, listen: false)
                  .removeProduct(widget.productId);
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ]),
      ),
    );
  }
}
