import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.grey[900],
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline_sharp,
          color: Colors.red,
        ),
        const SizedBox(width: 16.0),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10.0,
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 3),
  ));
}

void showSuccessSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.grey[900],
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        const SizedBox(width: 16.0),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ],
    ),
    duration: const Duration(seconds: 3),
  ));
}
