import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoes_app/components/custom_input_field.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';
import 'package:nike_shoes_app/utilities/utilis.dart';
import 'package:nike_shoes_app/view/home_screen.dart';
import 'package:nike_shoes_app/view/sign_up_screen.dart';
import 'package:nike_shoes_app/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Image.asset('assets/images/login-bg-img.png', fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 180),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 24),
                            const Center(
                              child: Text(
                                'Welcome Again',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            CustomInputField(
                              controller: _emailController,
                              hintText: 'Email',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: AppColors.primary,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email is required";
                                } else if (!value.contains('@')) {
                                  return "Enter a valid email";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              obscureText: isObscure,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: AppColors.primary,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  icon: isObscure
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: AppColors.primary,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: AppColors.primary,
                                        ),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: AlignmentGeometry.centerRight,
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: Size(double.infinity, 46),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    final UserCredential credential =
                                        await authProvider.login(
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                        );
                                    if (credential.user != null) {
                                      Utilis.showMessage(
                                        'Login Success!',
                                        Colors.green,
                                      );
                                      Future.delayed(
                                        const Duration(seconds: 1),
                                        () {
                                          Navigator.pushReplacement(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    Utilis.showMessage(e.message!, Colors.red);
                                  } catch (e) {
                                    Utilis.showMessage(
                                      e.toString(),
                                      Colors.red,
                                    );
                                  }
                                }
                              },
                              child: authProvider.isLoading
                                  ? const CircularProgressIndicator(
                                      color: AppColors.white,
                                    )
                                  : const Text('Login'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          238,
                          236,
                          236,
                        ),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 46),
                      ),
                      onPressed: () {
                        // Google Sign In logic here
                      },
                      label: const Text("Sign in with Google"),

                      icon: Image.asset(
                        'assets/images/google-icon.png',
                        width: 30,
                        height: 24,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          ),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
