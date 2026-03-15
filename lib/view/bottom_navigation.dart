import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/view/all_products.dart';
import 'package:nike_shoes_app/view/cart_screen.dart';
import 'package:nike_shoes_app/view/home_screen.dart';
import 'package:nike_shoes_app/view/profile_screen.dart';
import 'package:nike_shoes_app/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

int currentIndex = 0;

final List<Widget> pages = [
  const HomeScreen(),
  const CartScreen(),
  const AllProducts(),
  const ProfileScreen(),
];

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      // NOTE for myself:
      // flow always will be Main.dart -> authWrapper -> selected bottom navigation
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        iconSize: 28,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.white,
        elevation: 0,
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: [
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: '',
          ),

          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(CupertinoIcons.bag),
                Positioned(
                  left: 20,
                  bottom: 12,
                  child: Consumer<CartProvider>(
                    builder: (_, value, __) {
                      return Text(
                        value.noOfItemsInCart.toString(),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            label: '',
          ),

          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_grid_2x2),
            label: '',
          ),

          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
