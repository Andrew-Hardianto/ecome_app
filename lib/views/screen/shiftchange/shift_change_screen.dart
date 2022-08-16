import 'package:ecome_app/views/screen/widget/add-shift-change/add_shift_change.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ecome_app/utils/extension.dart';

class ShiftChangeScreen extends StatefulWidget {
  static const String routeName = '/shift-change';
  const ShiftChangeScreen({Key? key}) : super(key: key);

  @override
  State<ShiftChangeScreen> createState() => _ShiftChangeScreenState();
}

class _ShiftChangeScreenState extends State<ShiftChangeScreen> {
  List<dynamic> shiftList = [];
  bool drag = false;

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
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  cursorColor: Colors.green,
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
                          }).then((value) {
                        setState(() {
                          shiftList = value;
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (ctx) {},
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                          ),
                          SlidableAction(
                            onPressed: (ctx) {},
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: '#C0C0C0'.toColor()),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            )),
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text('Heads'),
                              decoration: BoxDecoration(
                                color: '#F2F2F2'.toColor(),
                                border: Border(
                                  bottom: BorderSide(
                                    color: '#C0C0C0'.toColor(),
                                  ),
                                ),
                                // borderRadius: BorderRadius.only(
                                //   topRight: Radius.circular(10),
                                //   topLeft: Radius.circular(10),
                                // )),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              height: 50,
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text('data'),
                                  Text('data'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height - 380,
              // ),
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
