import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get ItemCounts {
    print(_items.length);
    return _items.length;
  }

  double get getTotal {
    double total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    //check if already present in cart
    if (_items.containsKey(productId)) {
      //add quantity
      _items.update(
          productId,
          (existingCart) => CartItem(
              id: existingCart.id,
              title: existingCart.title,
              price: existingCart.price,
              quantity: existingCart.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now.toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearItem() {
    _items = {};
    notifyListeners();
  }

  List<CartItem> getCartItems() {
    List<CartItem> items = [];
    _items.forEach((key, value) {
      items.add(value);
    });
    return items;
  }
}
