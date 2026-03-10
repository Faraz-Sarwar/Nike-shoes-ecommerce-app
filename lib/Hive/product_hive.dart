// import 'package:hive/hive.dart';

// part 'product.g.dart';

// @HiveType(typeId: 0)
// class Product {
//   @HiveField(0)
//   final String id;

//   @HiveField(1)
//   final String name;

//   @HiveField(2)
//   final String description;

//   @HiveField(3)
//   final double price;

//   @HiveField(4)
//   final double ratings;

//   @HiveField(5)
//   final int reviewsCount;

//   @HiveField(6)
//   final String imagePath;

//   @HiveField(7)
//   final String category;

//   Product({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.ratings,
//     required this.reviewsCount,
//     required this.imagePath,
//     required this.category,
//   });

//   factory Product.fromMap(String docId, Map<String, dynamic> data) {
//     return Product(
//       id: docId,
//       name: data['name'] ?? '',
//       description: data['description'] ?? '',
//       price: (data['price'] ?? 0).toDouble(),
//       ratings: (data['ratings'] ?? 0).toDouble(),
//       reviewsCount: (data['reviewsCount'] ?? 0),
//       imagePath: (data['imageName'] ?? 'default.png').toString().trim(),
//       category: data['category'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'description': description,
//       'price': price,
//       'ratings': ratings,
//       'reviewsCount': reviewsCount,
//       'imagePath': imagePath,
//       'category': category,
//     };
//   }
// }
