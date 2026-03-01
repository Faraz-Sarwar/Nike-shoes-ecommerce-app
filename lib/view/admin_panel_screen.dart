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
  final ProductsViewModel productsVm = ProductsViewModel();
  @override
  Widget build(BuildContext context) {
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
            StreamBuilder<List<Product>>(
              stream: productsVm.getProducts(),
              builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      'No products curretly available',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.70,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, int index) {
                      final Product product = snapshot.data![index];

                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              height: 170,
                              productImages[index],
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    product.category,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        final TextEditingController
                                        categoryController =
                                            TextEditingController();
                                        final TextEditingController
                                        titleController =
                                            TextEditingController();
                                        final TextEditingController
                                        priceController =
                                            TextEditingController();

                                        //make data prefilled in the text form fields
                                        categoryController.text =
                                            product.category;
                                        titleController.text = product.name;
                                        priceController.text = product.price
                                            .toString();

                                        return Dialog(
                                          insetPadding: EdgeInsets.symmetric(
                                            horizontal: 24,
                                          ), // controls side spacing
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(16),

                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Title
                                                Text(
                                                  'Edit Product Info',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                SizedBox(height: 16),

                                                // Category
                                                TextFormField(
                                                  controller:
                                                      categoryController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Category',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),

                                                SizedBox(height: 12),

                                                // Title
                                                TextFormField(
                                                  controller: titleController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Title',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),

                                                SizedBox(height: 12),

                                                // Price
                                                TextFormField(
                                                  controller: priceController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: 'Price',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),

                                                SizedBox(height: 20),

                                                // Buttons
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                            context,
                                                          ),
                                                      child: Text('Cancel'),
                                                    ),
                                                    SizedBox(width: 10),
                                                    ElevatedButton(
                                                      onPressed: () async {
                                                        await productsVm
                                                            .editProductsInfo(
                                                              product.id,
                                                              categoryController
                                                                  .text,
                                                              titleController
                                                                  .text,
                                                              double.parse(
                                                                priceController
                                                                    .text,
                                                              ),
                                                            );
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Save'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    child: Icon(Icons.edit_outlined, size: 22),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Text(
                                product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Text(
                                    product.price.toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      topLeft: Radius.circular(10),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
