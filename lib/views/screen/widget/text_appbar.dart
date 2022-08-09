import 'package:flutter/material.dart';

class TextAppbar extends StatelessWidget {
  final String text;
  const TextAppbar({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
