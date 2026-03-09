import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/view/cart_screen.dart';
import 'package:nike_shoes_app/view/home_screen.dart';
import 'package:nike_shoes_app/view/profile_screen.dart';
import 'package:nike_shoes_app/view_model/cart_logic.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

int currentIndex = 0;
final List<Widget> pages = [HomeScreen(), CartScreen(), ProfileScreen()];

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return Scaffold(
      // NOTE for myself:
      //  flow always will be Main.dart -> authWrapper -> selected buttom navigation
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ''),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(CupertinoIcons.bag),
                Positioned(
                  left: 20.0,
                  bottom: 12.0,
                  child: Consumer(
                    builder: (_, value, _) {
                      return Text(
                        cartProvider.noOfItemsInCart.toString(),
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
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: ''),
        ],
      ),
    );
  }
}
