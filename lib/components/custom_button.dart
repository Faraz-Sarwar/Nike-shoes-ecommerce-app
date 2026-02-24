import 'package:flutter/material.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Widget text;
  final void Function()? onClick;
  const CustomButton({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primary,
        ),
        child: text,
      ),
    );
  }
}
