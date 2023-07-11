import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //     id: 'p1',
    //     title: 'Red Shirt',
    //     description: 'A red shirt.. Its pretty red',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn.theschoollocker.com.au/media/catalog/product/cache/1/image/500x650/9df78eab33525d08d6e5fb8d27136e95/5/1/51800-red-front_1.jpg'),
    // Product(
    //     id: 'p2',
    //     title: 'blue Shirt',
    //     description: 'A blue shirt.. Its pretty blue',
    //     price: 39.99,
    //     imageUrl:
    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCkIxHq5YVVKP_f8wQ2K4bCiomIqYk_JX5-5jxSoU&s'),
    // Product(
    //     id: 'p3',
    //     title: 'green Shirt',
    //     description: 'A green shirt.. Its pretty green',
    //     price: 49.99,
    //     imageUrl:
    //         'https://www.craftclothing.ph/cdn/shop/products/winner-plain-round-neck-shirt-ferngreen_58adf8f2-a30b-441c-878d-cffc4a26eb40.png?v=1644205060')
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

  Future<void> fetchAndSetProducts() async {
    try {
      Uri uri = Uri.https(
          "shop-app-1d376-default-rtdb.firebaseio.com", "/products.json");
      http.Response response = await http.get(uri);
      final extractedData = json.decode(response.body);
      print(json.decode(response.body));
      final List<Product> _loadedItems = [];
      extractedData.forEach((prodId, prodData) {
        _loadedItems.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl']));
      });
      _items = _loadedItems;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }

  Future<void> addProduct(Product product) async {
    // _items.add(value);
    // adding url to store into realtime firebase
    //https://stimg.cardekho.com/images/carexteriorimages/930x620/Lamborghini/Urus/9796/Lamborghini-Urus-S/1681372846634/front-left-side-47.jpg
    Uri uri = Uri.https(
        "shop-app-1d376-default-rtdb.firebaseio.com", "/products.json");

    Map<String, dynamic> body = {
      "title": product.title,
      "description": product.description,
      "price": product.price,
      "imageUrl": product.imageUrl
    };
    try {
      http.Response response = await http.post(uri, body: jsonEncode(body));
      final _finalproduct = Product(
          id: json.decode(response.body)["name"],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(_finalproduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void updateProduct(String productId, Product newproduct) {
    final productindex = _items.indexWhere((prod) => prod.id == productId);

    if (productindex >= 0) {
      _items[productindex] = newproduct;
      print(_items[productindex].title);
      notifyListeners();
    } else {
      print("......");
    }
  }

  void removeProduct(String productId) {
    _items.removeWhere((prod) => prod.id == productId);
    notifyListeners();
  }
}
