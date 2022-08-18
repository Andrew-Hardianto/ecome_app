import 'package:flutter/material.dart';

void SnackBarError(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    ),
    backgroundColor: Colors.red,
    duration: const Duration(milliseconds: 2000),
  ));
}

void SnackBarSuccess(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    ),
    backgroundColor: Colors.green,
    duration: const Duration(milliseconds: 2000),
  ));
}
