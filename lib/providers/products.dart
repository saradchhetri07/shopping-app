import 'package:flutter/material.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt.. Its pretty red',
        price: 29.99,
        imageUrl:
            'https://cdn.theschoollocker.com.au/media/catalog/product/cache/1/image/500x650/9df78eab33525d08d6e5fb8d27136e95/5/1/51800-red-front_1.jpg'),
    Product(
        id: 'p2',
        title: 'blue Shirt',
        description: 'A blue shirt.. Its pretty blue',
        price: 39.99,
        imageUrl:
            'https://cdn.theschoollocker.com.au/media/catalog/product/cache/1/image/500x650/9df78eab33525d08d6e5fb8d27136e95/5/1/51800-red-front_1.jpg'),
    Product(
        id: 'p3',
        title: 'green Shirt',
        description: 'A green shirt.. Its pretty green',
        price: 49.99,
        imageUrl:
            'https://cdn.theschoollocker.com.au/media/catalog/product/cache/1/image/500x650/9df78eab33525d08d6e5fb8d27136e95/5/1/51800-red-front_1.jpg')
  ];

  List<Product> get getItems {
    return [..._items];
  }

  List<Product> get getFavItems {
    print("get me fav item");
    return _items.where((prod) => prod.isFavorite).toList();
  }

  // void showfavoritesOnly() {
  //   _showfavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showfavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}