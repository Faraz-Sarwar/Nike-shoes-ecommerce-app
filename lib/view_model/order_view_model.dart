import 'package:flutter/cupertino.dart';
import 'package:nike_shoes_app/Hive/product_hive.dart';
import 'package:nike_shoes_app/repository/order_reposity.dart';

class OrderViewModel extends ChangeNotifier {
  final orderRepo = OrderReposity();

  Future<void> placeOrder(final uid, Product product) async {
    await orderRepo.placeOrder(uid, product);
    notifyListeners();
  }
}
