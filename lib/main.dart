import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/view/add_product.dart';
import 'package:nike_shoes_app/view/admin_panel_screen.dart';
import 'package:nike_shoes_app/view/auth_wrapper.dart';
import 'package:nike_shoes_app/view/home_screen.dart';
import 'package:nike_shoes_app/view/login_screen.dart';
import 'package:nike_shoes_app/view/sign_up_screen.dart';
import 'package:nike_shoes_app/view_model/auth_view_model.dart';
import 'package:nike_shoes_app/view_model/products_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => ProductsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            background: AppColors.background,
          ),

          // 🖼 Scaffold Background
          scaffoldBackgroundColor: AppColors.background,

          // 📝 Text Theme
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.textPrimary),
            bodyMedium: TextStyle(color: AppColors.textPrimary),
            bodySmall: TextStyle(color: AppColors.textSecondary),
          ),

          // 🧱 AppBar Theme
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.textPrimary),
          ),

          // 🟦 Elevated Button Theme
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}
