import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsRepository {
  final CollectionReference productCollection = FirebaseFirestore.instance
      .collection('products');

  Stream<List<Map<String, dynamic>>> getAllProducts() {
    return FirebaseFirestore.instance.collection('products').snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  Future<DocumentReference> addProduct(
    String name,
    String description,
    double price,
    String category,
    double ratings,
    int noOfReviews,
    String imagePath,
  ) async {
    try {
      final docRef = await productCollection.add({
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'ratings': ratings,
        'reviewsCount': noOfReviews,
        'imagePath': imagePath,
      });
      return docRef;
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }
}
