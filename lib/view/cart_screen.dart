import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/data/product_images.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/view/checkout_page.dart';
import 'package:nike_shoes_app/view_model/cart_logic.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = context.watch<CartProvider>();
    double subTotal = cartProvider.getTotalPrice();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You currently have ${cartProvider.noOfItemsInCart} items in cart',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.itemsInCart.length,
                itemBuilder: (context, index) {
                  final product = cartProvider.itemsInCart[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        // ✅ Image
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 237, 236, 236),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Image.asset(
                            productImages[index],
                            fit: BoxFit.cover,
                            scale: 9,
                          ),
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => cartProvider
                                          .removeItemFromCart(product),
                                      child: const Icon(
                                        CupertinoIcons.delete,
                                        color: AppColors.primary,
                                        size: 22,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  product.price.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.amberAccent,
                                        ),
                                        Text(
                                          product.ratings.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          ' (${product.reviewsCount} Reviews)',
                                        ),
                                      ],
                                    ),

                                    Text('(${product.category})'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Visibility(
          visible: subTotal > 0 ? true : false,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => const CheckoutPage()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  subTotal.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Go to checkout', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
