import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_shoes_app/model/product.dart';

class ProductsRepository {
  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection('products');

  // Stream<List<Product>> getAllProducts() {
  //   return FirebaseFirestore.instance.collection('products').snapshots().map((
  //     snapshot,
  //   ) {
  //     return snapshot.docs.map((doc) {
  //       return Product.fromMap(doc.id, doc.data())
  //     }).toList();
  //   });
  // }

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

  // Future<DocumentReference> addProduct(
  //   String name,
  //   String description,
  //   double price,
  //   String category,
  //   double ratings,
  //   int noOfReviews,
  //   String imagePath,
  // ) async {
  //   try {
  //     final docRef = await productCollection.add({
  //       'name': name,
  //       'description': description,
  //       'price': price,
  //       'category': category,
  //       'ratings': ratings,
  //       'reviewsCount': noOfReviews,
  //       'imagePath': imagePath,
  //     });
  //     return docRef;
  //   } catch (e) {
  //     print('failed to add product $e');
  //     throw Exception('Failed to add product: $e');
  //   }
  // }

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
}
