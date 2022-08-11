import 'package:ecome_app/views/screen/checkinout/checkinout_service.dart';
import 'package:ecome_app/views/screen/widget/map/google_map_screen.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecome_app/utils/extension.dart';

class CheckinoutScreen extends StatefulWidget {
  static const String routeName = '/check-in-out';
  const CheckinoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckinoutScreen> createState() => _CheckinoutScreenState();
}

class _CheckinoutScreenState extends State<CheckinoutScreen> {
  final checkinoutService = CheckInOutService();

  int groupValue = 0;
  String userLoc = 'inOffice';

  @override
  void initState() {
    super.initState();
    checkinoutService.getLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final type = data['type'];
    List<String> items = ['1', '2', '3'];
    String? selectedItem;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextAppbar(text: type!),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: MapScreen(),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: CupertinoSegmentedControl(
                  selectedColor: Colors.green,
                  borderColor: Colors.green,
                  pressedColor: Colors.green.shade300,
                  groupValue: groupValue,
                  children: {
                    0: Text(
                      'In The Office',
                      style: TextStyle(fontSize: 14),
                    ),
                    1: Text(
                      'Outside The Office',
                      style: TextStyle(fontSize: 14),
                    ),
                  },
                  onValueChanged: (val) {
                    print(val);
                    setState(() {
                      groupValue = val as int;
                      if (val == 1) {
                        userLoc = 'outOffice';
                      } else {
                        userLoc = 'inOffice';
                      }
                    });
                  },
                ),
              ),
              if (groupValue == 1)
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Purpose ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          hintText: 'Example : Work From Home',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        items: items.map((e) {
                          return DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedItem = value as String?;
                          });
                        },
                        value: selectedItem,
                      ),
                    ],
                  ),
                ),
              if (groupValue == 1)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Remarks ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '*',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Example : Fixing Module',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        cursorColor: Colors.green,
                      )
                    ],
                  ),
                ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: ['#52f03d'.toColor(), '#7ff03d'.toColor()],
                  ),
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  child: Text('SUBMIT'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                    ),
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
