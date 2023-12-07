import 'package:flutter/material.dart';

void showSuccessMessage(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: 1),
    backgroundColor: Colors.green,
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showFailedMessage(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    duration: const Duration(seconds: 1),
    backgroundColor: Colors.red,
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
