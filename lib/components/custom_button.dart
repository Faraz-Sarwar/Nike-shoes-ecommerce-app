import 'package:flutter/material.dart';
import 'package:nike_shoes_app/utilities/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Widget text;
  final void Function()? onClick;
  const CustomButton({super.key, required this.text, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
      onPressed: onClick,
      child: text,
    );
  }
}
