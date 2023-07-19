import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop/providers/orders.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  // AnimationController _controller;

  OrderItem(this.order);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
      height:
          _expanded ? min(widget.order.products.length * 20 + 150, 250) : 100,
      child: Card(
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
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                height: _expanded
                    ? min(widget.order.products.length * 30 + 100, 60)
                    : 0,
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
          )),
    );
  }
}
