import 'package:flutter/material.dart';
import 'package:nike_shoes_app/components/custom_input_field.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/utilities/utilis.dart';
import 'package:nike_shoes_app/view_model/products_view_model.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController ratingsController = TextEditingController();
  final TextEditingController reviewsCountController = TextEditingController();
  final TextEditingController imageNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    ratingsController.dispose();
    reviewsCountController.dispose();
    imageNameController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productVM = context.read<ProductsViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add a product'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'All fields are required*',
                  style: TextStyle(color: AppColors.primary),
                ),
                const SizedBox(height: 8),
                CustomInputField(
                  controller: nameController,
                  hintText: 'Add product name',
                  prefixIcon: Icon(Icons.shopping_bag_outlined),
                  inputKeyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Product name is required";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 32),
                CustomInputField(
                  controller: descriptionController,
                  hintText: 'Add a description',
                  prefixIcon: Icon(Icons.text_snippet_outlined),
                  inputKeyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Product description is required";
                    } else {
                      return null;
                    }
                  },
                ),

                const SizedBox(height: 32),
                CustomInputField(
                  controller: priceController,
                  hintText: 'Enter retail price',
                  prefixIcon: Icon(Icons.attach_money_outlined),
                  inputKeyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Product price is required";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 32),
                CustomInputField(
                  controller: categoryController,
                  hintText: 'Product category',
                  prefixIcon: Icon(Icons.shopping_cart_outlined),
                  inputKeyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Product category is required";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 32),
                CustomInputField(
                  controller: ratingsController,
                  hintText: 'Product Ratings',
                  prefixIcon: Icon(Icons.star),

                  inputKeyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Product Ratings is required";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 32),
                CustomInputField(
                  controller: reviewsCountController,
                  hintText: 'No of reviews',
                  prefixIcon: Icon(Icons.thumb_up_alt),
                  inputKeyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Product reviews is required";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 32),
                CustomInputField(
                  controller: imageNameController,
                  hintText: 'Image Path',
                  prefixIcon: Icon(Icons.image),
                  inputKeyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Product Image Path is required";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final doc = await productVM.addProducts(
                          nameController.text.trim(),
                          descriptionController.text.trim(),
                          double.parse(priceController.text),
                          categoryController.text,
                          double.parse(ratingsController.text),
                          int.parse(reviewsCountController.text),
                          imageNameController.text,
                        );
                        if (doc.id.isNotEmpty) {
                          Utilis.showMessage(
                            'Product added successfully',
                            Colors.green,
                          );
                        }
                      } catch (e) {
                        Utilis.showMessage(e.toString(), Colors.red);
                      }
                    }
                  },
                  child: Center(
                    child: productVM.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : const Text('Add product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
