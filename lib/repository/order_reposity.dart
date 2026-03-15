import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoes_app/Hive/product_hive.dart';
import 'package:nike_shoes_app/view_model/cart_view_model.dart';

class OrderReposity {
  final orderCollection = FirebaseFirestore.instance.collection('orders');
  final cart = CartProvider();

  Future<void> placeOrder(final String uid, Product product) async {
    orderCollection.add({
      'name': product.name,
      'description': product.description,
      'address': '123',
      'subtotal': cart.getTotalPrice(),
    });
  }
}
