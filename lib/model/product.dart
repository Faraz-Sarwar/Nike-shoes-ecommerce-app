class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double ratings;
  final int reviewsCount;
  final String imageName;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.ratings,
    required this.reviewsCount,
    required this.imageName,
    required this.category,
  });

  /// Create Product from Firestore document
  factory Product.fromMap(String docId, Map<String, dynamic> data) {
    return Product(
      id: docId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      ratings: (data['ratings'] ?? 0).toDouble(),
      reviewsCount: (data['reviewsCount'] ?? 0),
      imageName: data['imageName'] ?? 'default.png',
      category: data['category'] ?? '',
    );
  }

  /// Convert Product to Map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'ratings': ratings,
      'reviewsCount': reviewsCount,
      'imageName': imageName,
      'category': category,
    };
  }
}
