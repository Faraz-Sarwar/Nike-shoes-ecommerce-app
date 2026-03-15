import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/components/custom_button.dart';
import 'package:nike_shoes_app/components/custom_input_field.dart';
import 'package:nike_shoes_app/components/order_summary_row_text.dart';
import 'package:nike_shoes_app/data/product_images.dart';
import 'package:nike_shoes_app/model/product.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/utilities/utilis.dart';
import 'package:nike_shoes_app/view/all_products.dart';
import 'package:nike_shoes_app/view/home_screen.dart';
import 'package:nike_shoes_app/view_model/cart_view_model.dart';
import 'package:nike_shoes_app/view_model/order_view_model.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    _streetController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    final List<Product> products = cartProvider.itemsInCart;
    final orderVm = context.read<OrderViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Checkout'),
        surfaceTintColor: AppColors.white,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // Scrollable content
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 80,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Selected items
                      Text(
                        'Selected items (${cartProvider.noOfItemsInCart})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: constraints.maxHeight * 0.25,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ListView.builder(
                          itemCount: products.length,
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final Product product = products[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.background.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  GestureDetector(
                                    onTap: () {
                                      cartProvider.removeItemFromCart(product);
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

                      // Order summary & address
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.textSecondary,
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderSummaryRowText(
                                text: 'Subtotal',
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                isBoldText: false,
                                value: Text(
                                  cartProvider.getTotalPrice().toStringAsFixed(
                                    2,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              OrderSummaryRowText(
                                text: 'Shipping fee',
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                isBoldText: false,
                                value: const Text('0.0'),
                              ),
                              const SizedBox(height: 6),
                              OrderSummaryRowText(
                                text: 'Tax fee',
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                isBoldText: false,
                                value: const Text('0.0'),
                              ),
                              const SizedBox(height: 12),
                              OrderSummaryRowText(
                                text: 'ORDER TOTAL',
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                isBoldText: true,
                                value: Text(
                                  cartProvider.getTotalPrice().toStringAsFixed(
                                    2,
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Divider(
                                thickness: 2,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Shipping address',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 12),
                              CustomInputField(
                                controller: _cityController,
                                hintText: 'eg: Karachi',
                              ),
                              const SizedBox(height: 12),
                              CustomInputField(
                                controller: _streetController,
                                hintText:
                                    'eg: ABC road, XYX apartment, 1st floor',
                              ),
                              const SizedBox(height: 12),
                              CustomInputField(
                                controller: _phoneController,
                                hintText: '+92 3063179266',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 120), // extra space for FAB
                    ],
                  ),
                ),

                // Floating Place Order Button
                Positioned(
                  bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  child: CustomButton(
                    text: orderVm.isLoading
                        ? const CircularProgressIndicator()
                        : Text('Place Order'),
                    onClick: () async {
                      try {
                        await orderVm.placeOrder(products, {
                          'City': _cityController.text,
                          'Street': _streetController.text,
                          'Phone': _phoneController.text,
                        });
                        _cityController.clear();
                        _streetController.clear();
                        _phoneController.clear();
                        cartProvider.clearCart();

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: AppColors.primary,
                                    size: 40,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Order Placed!",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "Your order has been placed successfully.\nYou will receive confirmation shortly.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: CustomButton(
                                    text: Text("Continue Shopping"),
                                    onClick: () {
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (_) => const HomeScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } catch (e) {
                        Utilis.showMessage(e.toString(), Colors.red);
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
