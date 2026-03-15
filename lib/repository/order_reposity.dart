import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nike_shoes_app/model/product.dart';
import 'package:nike_shoes_app/view_model/cart_view_model.dart';

class OrderReposity {
  final orderCollection = FirebaseFirestore.instance.collection('orders');
  final cart = CartProvider();

  Future<void> placeOrder(List<Product> cartProducts, Map address) async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final List itemsInCart = cartProducts.map((product) {
        return {
          'Product ID': product.id,
          'Product name': product.name,
          'price': product.price,
        };
      }).toList();
      double subtotal = 0;
      for (var item in cartProducts) {
        subtotal += item.price;
      }
      orderCollection.add({
        'orderId': uid,
        'items': itemsInCart,
        'subtotal': subtotal.toStringAsFixed(2),
        'address': address,
        'orderAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
