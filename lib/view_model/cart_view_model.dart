import 'package:flutter/material.dart';
import 'package:nike_shoes_app/model/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];

  // Get all items
  List<Product> get itemsInCart => _cart;

  // Number of items
  int get noOfItemsInCart => _cart.length;

  // Check if item already exists
  bool isAlreadyInCart(Product product) {
    return _cart.any((p) => p.name == product.name);
  }

  // Add item
  void addItemInCart(Product product) {
    if (!isAlreadyInCart(product)) {
      _cart.add(product);
      notifyListeners();
    }
  }

  // Remove item
  void removeItemFromCart(Product product) {
    _cart.removeWhere((p) => p.name == product.name);
    notifyListeners();
  }

  // Calculate total price
  double getTotalPrice() {
    double subTotal = 0;

    for (var item in _cart) {
      subTotal += item.price;
    }

    return subTotal;
  }

  // Clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
