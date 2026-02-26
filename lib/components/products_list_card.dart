import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/data/product_images.dart';
import 'package:nike_shoes_app/model/product.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/view_model/products_view_model.dart';

class ProductsListCard extends StatelessWidget {
  const ProductsListCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsViewModel productsVm = ProductsViewModel();
    return StreamBuilder<List<Product>>(
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        product.category,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                          child: Icon(Icons.add, color: AppColors.white),
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
    );
  }
}
