import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/components/products_list_card.dart';
import 'package:nike_shoes_app/data/product_images.dart';
import 'package:nike_shoes_app/model/product.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/view/add_product.dart';
import 'package:nike_shoes_app/view_model/products_view_model.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  @override
  Widget build(BuildContext context) {
    final ProductsViewModel productsVm = ProductsViewModel();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        title: const Text('Admin Panel'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => AddProduct()),
              );
            },
            icon: Icon(Icons.add, size: 34),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current available products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 32),
            const ProductsListCard(),
          ],
        ),
      ),
    );
  }
}
