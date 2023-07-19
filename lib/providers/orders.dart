import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String? id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Order extends ChangeNotifier {
  String? auth_token;
  String? userId;
  List<OrderItem> _orders = [];
  Order(this.auth_token, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> FetchAndSetOrders() async {
    try {
      final url =
          "https://shop-app-1d376-default-rtdb.firebaseio.com/orders/$userId.json?auth=${auth_token}";
      final response = await http.get(Uri.parse(url));

      final _extractedData = json.decode(response.body);

      if (_extractedData == null) {
        return;
      }
      final List<OrderItem> loadedItem = [];
      _extractedData.forEach((orderId, orderData) {
        loadedItem.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData!['dateTime']),
            products: (orderData!['products'] as List<dynamic>)
                .map((item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title']))
                .toList()));
      });
      _orders = loadedItem;
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addOrder(List<CartItem> cartproducts, double total) async {
    try {
      final url =
          "https://shop-app-1d376-default-rtdb.firebaseio.com/orders/$userId.json?auth=$auth_token";
      final currentDate = DateTime.now();
      Map<String, dynamic> body = {
        "amount": total,
        "dateTime": currentDate.toIso8601String(),
        "products": cartproducts
            .map((cartItem) => {
                  'id': cartItem.id,
                  'title': cartItem.title,
                  'price': cartItem.price,
                  'quantity': cartItem.quantity
                })
            .toList()
      };
      final response = await http.post(Uri.parse(url), body: json.encode(body));
      print(json.decode(response.body));
      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)["name"],
            amount: total,
            products: cartproducts,
            dateTime: DateTime.now(),
          ));

      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
