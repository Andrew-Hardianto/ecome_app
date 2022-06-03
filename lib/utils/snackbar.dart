import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Error message
showSnackbarError(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red[900],
  ));
}

// Success message
showSnackbarSuccess(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.green,
  ));
}
