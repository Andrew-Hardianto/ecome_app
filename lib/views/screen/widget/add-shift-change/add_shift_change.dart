import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddShiftChange extends StatefulWidget {
  const AddShiftChange({Key? key}) : super(key: key);

  @override
  State<AddShiftChange> createState() => _AddShiftChangeState();
}

class _AddShiftChangeState extends State<AddShiftChange> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height - 300,
        child: Center(
          child: Text('Add Shift'),
        ),
      ),
    );
  }
}
