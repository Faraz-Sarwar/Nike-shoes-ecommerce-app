import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:nike_shoes_app/repository/products_repository.dart';

class ProductsViewModel extends ChangeNotifier {
  //get all products from firebase
  final ProductsRepository productRepo = ProductsRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Stream<List<Map<String, dynamic>>> getProducts() {
    try {
      _isLoading = true;
      notifyListeners();
      final products = productRepo.getAllProducts();
      _isLoading = false;
      notifyListeners();
      return products;
    } catch (e) {
      throw Exception("Error occured while fetching products: ${e.toString()}");
    }
  }

  Future<DocumentReference> addProducts(
    String name,
    String description,
    double price,
    String category,
    double ratings,
    int noOfReviews,
    String imagePath,
  ) async {
    _isLoading = true;
    notifyListeners();
    final doc = await productRepo.addProduct(
      name,
      description,
      price,
      category,
      ratings,
      noOfReviews,
      imagePath,
    );
    _isLoading = false;
    notifyListeners();
    return doc;
  }
}
