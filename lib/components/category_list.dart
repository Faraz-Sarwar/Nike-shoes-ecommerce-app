import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/data/categories.dart';
import 'package:nike_shoes_app/data/product_images.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/view_model/products_view_model.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int categorySelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ProductsViewModel productVM = ProductsViewModel();
    return FutureBuilder<Set<String>>(
      future: productVM.getCategories(),
      builder: (context, snapshot) {
        //Show ONE loader
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        //Handle no data
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No categories found'));
        }

        //Convert Set → List
        final categoryList = snapshot.data!.toList();

        return ListView.builder(
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final category = categoryList[index];

            return GestureDetector(
              onTap: () {
                setState(() {
                  categorySelectedIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                width: 160,
                decoration: BoxDecoration(
                  color: categorySelectedIndex == index
                      ? AppColors.primary
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset(
                            productImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          category,
                          style: TextStyle(
                            color: categorySelectedIndex == index
                                ? AppColors.white
                                : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
