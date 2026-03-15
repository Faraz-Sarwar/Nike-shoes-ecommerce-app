import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/components/order_summary_row_text.dart';
import 'package:nike_shoes_app/data/product_images.dart';
import 'package:nike_shoes_app/model/product.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/view_model/cart_view_model.dart';
import 'package:nike_shoes_app/view_model/order_view_model.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Checkout'),
        surfaceTintColor: AppColors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Selected Items
            Text(
              'Selected items (${cartProvider.noOfItemsInCart})',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Container for fixed-height scrollable list
            Container(
              height: screenHeight * 0.20,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ListView.builder(
                itemCount: cartProvider.noOfItemsInCart,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final Product product = cartProvider.itemsInCart[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.background.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Product image
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          child: Image.asset(
                            productImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Product details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Delete icon
                        GestureDetector(
                          onTap: () {
                            cartProvider.removeItemFromCart(
                              product,
                            ); // make sure this method exists
                          },
                          child: const Icon(
                            CupertinoIcons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.textSecondary, width: 0.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderSummaryRowText(
                      text: 'Subtotal',

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      isBoldText: false,
                      value: Text(
                        cartProvider.getTotalPrice().toStringAsFixed(2),
                      ),
                    ),

                    const SizedBox(height: 6),
                    OrderSummaryRowText(
                      text: 'Shipping fee',

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      value: const Text('0,0'),
                      isBoldText: false,
                    ),

                    const SizedBox(height: 6),
                    OrderSummaryRowText(
                      text: 'Tax fee',

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      value: const Text('0.0'),
                      isBoldText: false,
                    ),
                    const SizedBox(height: 12),
                    OrderSummaryRowText(
                      text: 'ORDER TOTAL',
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      value: Text(
                        cartProvider.getTotalPrice().toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      isBoldText: true,
                    ),
                    const SizedBox(height: 6),
                    Divider(thickness: 2, color: AppColors.textSecondary),
                    const Text(
                      'Shipping address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    OrderSummaryRowText(
                      mainAxisAlignment: MainAxisAlignment.start,
                      text: 'Phone:',
                      value: const Text('1+3801 2131232'),
                      isBoldText: true,
                    ),
                    const SizedBox(height: 4),
                    OrderSummaryRowText(
                      text: 'Address:',

                      mainAxisAlignment: MainAxisAlignment.start,
                      value: Expanded(
                        child: const Text(
                          'Mainhatton st new york south liana main',
                        ),
                      ),
                      isBoldText: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
