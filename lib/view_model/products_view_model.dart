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

  Future<Set<String>> getCategories() async {
    final Set<String> categories = await productRepo.getAllCategories();
    return categories;
  }

  Future<void> editProductsInfo(
    String id,
    String category,
    String title,
    double price,
  ) async {
    await productRepo.editProductsInfo(id, category, title, price);
    notifyListeners();
  }

  Future<void> deleteProduct(Product product) async {
    try {
      await productRepo.deleteProduct(product);
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
