import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nike_shoes_app/model/product.dart';
import 'package:nike_shoes_app/repository/products_repository.dart';

class ProductsViewModel extends ChangeNotifier {
  //get all products from firebase
  final ProductsRepository productRepo = ProductsRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  Stream<List<Product>> getProducts() {
    try {
      _isLoading = true;
      notifyListeners();
      final Stream<List<Product>> products = productRepo.getAllProducts();
      _isLoading = false;
      notifyListeners();
      return products;
    } catch (e) {
      throw Exception("Error occured while fetching products: ${e.toString()}");
    }
  }

  Future<DocumentReference> addProducts(Product product) async {
    _isLoading = true;
    notifyListeners();

    final doc = await productRepo.addProduct(product);

    _isLoading = false;
    notifyListeners();

    return doc;
  }
}
