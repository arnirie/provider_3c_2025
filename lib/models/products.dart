import 'package:flutter/material.dart';

class Products extends ChangeNotifier {
  final List<Product> _products = [
    Product(id: 1, name: 'Patek Philippe', desc: 'watch', price: 15000000),
  ];

  List<Product> get items => _products;

  int get count {
    return _products.length;
  }

  void add(Product p) {
    _products.add(p);
    notifyListeners(); //all UI depending on this class will be updated
  }

  // void toggleFavorite(int index) {
  //   _products[index].isFav = !_products[index].isFav;
  //   notifyListeners();
  // }

  void toggleFavorite(Product p) {
    p.isFav = !p.isFav;
    notifyListeners();
  }
}

class Product {
  final int id;
  final String name;
  final String desc;
  final double price;
  late bool isFav;

  Product({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    this.isFav = false,
  });
}
