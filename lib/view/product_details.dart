import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/model/product.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.product.category} shoes'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag_rounded)),
        ],
      ),
      body: Column(children: []),
    );
  }
}
