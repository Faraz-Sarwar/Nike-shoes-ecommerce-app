import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/components/category_list.dart';
import 'package:nike_shoes_app/data/product_images.dart';
import 'package:nike_shoes_app/model/product.dart';
import 'package:nike_shoes_app/repository/user_data.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/utilities/utilis.dart';
import 'package:nike_shoes_app/view/admin_panel_screen.dart';
import 'package:nike_shoes_app/view/product_page.dart';
import 'package:nike_shoes_app/view_model/auth_view_model.dart';
import 'package:nike_shoes_app/view_model/products_view_model.dart';
import 'package:nike_shoes_app/view_model/user_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserData userData = UserData();
  final AuthViewModel authRepo = AuthViewModel();
  final UserViewModel userModel = UserViewModel();

  int categorySelectedIndex = 0;

  //resuable function to extract user data
  Widget getUserData(String userData) {
    return FutureBuilder(
      future: userModel.getUserData(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Text('User');
        } else {
          final data = snapshot.data;
          return Text(data![userData]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProductsViewModel productsVm = ProductsViewModel();
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              //using reusable widgets
              accountName: getUserData('name'),
              accountEmail: getUserData('email'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: const AssetImage('assets/images/profile.png'),
              ),
              decoration: BoxDecoration(color: AppColors.primary),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Orders'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await authRepo.logout();
              },
            ),
            Divider(),

            //This will take the admin to the admin panel to add, edit, delete products in the firebase firestore database
            ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text('Go  to admin panel'),
              onTap: () async {
                //Autheticate if user is admin or NOT
                final bool admin = await userModel.isAdmin();
                if (admin) {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => AdminPanelScreen()),
                  );
                } else {
                  Utilis.showMessage('Access Denied', Colors.red);
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 28)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  //Banner image
                  child: Image.asset('assets/images/nike-hero-banner.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New Release',
                        style: TextStyle(color: AppColors.white, fontSize: 18),
                      ),

                      const Text(
                        'Nike Air\nMax 90',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.w900,

                          letterSpacing: 2.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.white,
                        ),
                        child: const Center(
                          child: Text(
                            'Shop Now',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 60,
              //search products by category section
              child: const CategoryList(),
            ),
            const SizedBox(height: 32),
            const Text(
              "New Men's",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            //Fetch all products from firebase
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

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ProductPage(product: product),
                          ),
                        ),
                        child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
