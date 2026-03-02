import 'package:flutter/widgets.dart';
import 'package:nike_shoes_app/model/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> itemsInCart = [];
  int get noOfItemsInCart => itemsInCart.length;

  //Check if an item exists in cart
  bool isAlreadyInCart(Product product) {
    if (itemsInCart.any((p) => p.name == product.name)) {
      return true;
    } else {
      return false;
    }
  }

  //add in the cart only if its not already present.
  void addItemInCart(Product product) {
    if (!isAlreadyInCart(product)) {
      itemsInCart.add(product);
      notifyListeners();
    }
  }

  //before removing, check if it exists in the cart
  void removeItemFromCart(Product product) {
    if (isAlreadyInCart(product)) {
      itemsInCart.remove(product);
      notifyListeners();
    }
  }
}
