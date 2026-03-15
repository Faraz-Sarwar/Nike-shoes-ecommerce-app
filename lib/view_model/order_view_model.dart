import 'package:flutter/cupertino.dart';
import 'package:nike_shoes_app/model/product.dart';
import 'package:nike_shoes_app/repository/order_reposity.dart';

class OrderViewModel extends ChangeNotifier {
  final orderRepo = OrderReposity();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> placeOrder(List<Product> products, Map address) async {
    try {
      _isLoading = true;
      notifyListeners();
      await orderRepo.placeOrder(products, address);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
