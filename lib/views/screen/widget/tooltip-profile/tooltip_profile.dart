import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TooltipProfile extends StatelessWidget {
  final user;
  const TooltipProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // print(user.alias);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 10),
              blurRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}
