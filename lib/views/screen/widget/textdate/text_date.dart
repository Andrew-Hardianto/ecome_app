import 'package:flutter/material.dart';

class TextDate extends StatelessWidget {
  final VoidCallback onClick;
  final TextEditingController ctrl;
  const TextDate({
    Key? key,
    required this.onClick,
    required this.ctrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 50,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
      ),
      child: TextField(
        style: TextStyle(fontSize: 14),
        controller: ctrl,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: -10),
          icon: Icon(
            Icons.calendar_today,
            size: 18,
          ),
          hintText: 'DD/MM/YYYY',
          hintStyle: TextStyle(fontSize: 12),
          border: InputBorder.none,
        ),
        readOnly: true,
        onTap: onClick,
      ),
    );
  }
}
