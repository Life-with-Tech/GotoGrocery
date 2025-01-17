import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void showToast(
    String message, {
    Color bgColor = Colors.white,
    Color textColor = Colors.black,
    double fontSize = 16,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) =>
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: fontSize,
      );
}
