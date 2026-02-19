import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilis {
  static void showMessage(String message, Color color) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: color,
      textColor: Colors.white,
    );
  }
}
