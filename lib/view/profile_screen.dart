import 'package:flutter/material.dart';
import 'package:nike_shoes_app/components/custom_button.dart';
import 'package:nike_shoes_app/components/custom_input_field.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage profile')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  radius: 70,
                  child: Image.asset('assets/images/profile.png'),
                ),
              ),
              const SizedBox(height: 64),
              CustomInputField(controller: nameController, hintText: 'Name'),
              const SizedBox(height: 16),
              CustomInputField(controller: nameController, hintText: 'Email'),
              const SizedBox(height: 16),
              CustomInputField(controller: nameController, hintText: 'Phone'),
              const SizedBox(height: 16),
              CustomInputField(
                controller: nameController,
                hintText: 'location',
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: Center(
                  child: const Text(
                    'Save profile',
                    style: TextStyle(color: AppColors.white, fontSize: 18),
                  ),
                ),
                onClick: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
