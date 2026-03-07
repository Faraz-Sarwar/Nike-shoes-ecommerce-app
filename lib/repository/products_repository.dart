import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoes_app/model/product.dart';

class ProductsRepository {
  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection('products');

  Stream<List<Product>> getAllProducts() {
    return productCollection.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) =>
                Product.fromMap(doc.id, doc.data() as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Future<DocumentReference> addProduct(Product product) async {
    try {
      final docRef = productCollection.add(product.toMap());
      return docRef;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Set<String>> getAllCategories() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .get();
    final Set<String> categories = {};
    for (var doc in snapshot.docs) {
      final data = doc.data();
      categories.add(data['category']);
    }
    return categories;
  }

  Future<void> editProductsInfo(
    String id,
    String categoryInfo,
    String titleInfo,
    double priceInfo,
  ) async {
    await productCollection.doc(id).update({
      'category': categoryInfo,
      'name': titleInfo,
      'price': priceInfo,
    });
  }

  Future<void> deleteProduct(Product product) async {
    await productCollection.doc(product.id).delete();
  }
}
