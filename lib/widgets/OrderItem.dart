import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop/providers/orders.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text("${widget.order.amount}"),
              subtitle: Text(DateFormat("dd/MM/yyyy    hh:mm")
                  .format(widget.order.dateTime)),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  icon: _expanded
                      ? const Icon(
                          Icons.expand_less,
                        )
                      : const Icon(
                          Icons.expand_more,
                        )),
            ),
            if (_expanded)
              Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                height: min(widget.order.products.length * 30 + 10, 180),
                child: ListView(
                  children: widget.order.products
                      .map((product) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${product.title}",
                                style: TextStyle(fontSize: 20.0),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${product.quantity}x",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    "${product.quantity * product.price}",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              )
                            ],
                          ))
                      .toList(),
                ),
              )
          ],
        ));
  }
}
