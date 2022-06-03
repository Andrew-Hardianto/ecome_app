import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TagList extends StatelessWidget {
  final tagList = [
    'Woman',
    'T-Shirt',
    'Dress',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: tagList
          .map(
            (e) => Container(
              margin: EdgeInsets.all(14),
              padding: EdgeInsets.all(10),
              child: Text(
                e,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
          .toList(),
    );
  }
}
