import 'package:ecome_app/views/screen/widget/add-shift-change/add_shift_change.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShiftChangeScreen extends StatefulWidget {
  static const String routeName = '/shift-change';
  const ShiftChangeScreen({Key? key}) : super(key: key);

  @override
  State<ShiftChangeScreen> createState() => _ShiftChangeScreenState();
}

class _ShiftChangeScreenState extends State<ShiftChangeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextAppbar(text: 'Shift Change'),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  'What is the reason for shift change?',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Example: Shift change due health issues',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('+ Add List'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AddShiftChange();
                          });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 380,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Submit'),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
