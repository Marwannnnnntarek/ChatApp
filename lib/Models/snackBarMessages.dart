import 'package:flutter/material.dart';

class SnackBarMessage {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red, // Customize as needed
      ),
    );
  }
}
