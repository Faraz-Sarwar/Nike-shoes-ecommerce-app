import 'package:flutter/foundation.dart';

class Category {
  String name;
  String image;

  Category({required this.name, required this.image});
}

final List<Category> categories = [
  Category(name: 'Fashion', image: 'assets/images/nike-red-wh.png'),
  Category(name: 'Running', image: 'assets/images/nike-green.png'),
  Category(name: 'Casual', image: 'assets/images/nike-wh-grey.png'),
];
