import 'dart:convert';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/views/screen/widget/textdate/text_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddShiftChange extends StatefulWidget {
  final String action;
  final Map<String, dynamic>? data;
  const AddShiftChange({Key? key, required this.action, this.data})
      : super(key: key);

  @override
  State<AddShiftChange> createState() => _AddShiftChangeState();
}

class _AddShiftChangeState extends State<AddShiftChange> {
  final mainService = MainService();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  DateTime shiftStartDate = DateTime.now();
  DateTime shiftEndDate = DateTime.now();

  List<dynamic> optShift = [];

  String? selectedItem;
  String? selectedName;

  @override
  void initState() {
    super.initState();
    getShift(context);
    if (widget.action == 'edit') {
      this.shiftStartDate = widget.data!['shiftStartDate'];
      this.shiftEndDate = widget.data!['shiftEndDate'];
      this.startDate.text =
          DateFormat('dd MMM yyyy').format(widget.data!['shiftStartDate']);
      this.endDate.text =
          DateFormat('dd MMM yyyy').format(widget.data!['shiftEndDate']);
      this.selectedItem = widget.data!['shiftId'];
      this.selectedName = widget.data!['shiftName'];
    }
  }

  selectedDate(String type) async {
    DatePicker.showDatePicker(
      context,
      theme: DatePickerTheme(
        containerHeight: 250.0,
      ),
      minTime: type == 'end' ? shiftStartDate : DateTime(2000),
      maxTime: DateTime(DateTime.now().year, 12, 31),
      onConfirm: (time) {
        if (type == 'start') {
          shiftStartDate = time;
          startDate.text = DateFormat('dd MMM yyyy').format(time);
          shiftEndDate = DateTime.now();
          endDate.clear();
        } else {
          shiftEndDate = time;
          endDate.text = DateFormat('dd MMM yyyy').format(time);
        }
      },
    );
  }

  getShift(BuildContext context) async {
    var url = await mainService.urlApi() + '/api/v1/lookup/shift/shiftchange';

    mainService.getUrl(url, (res) {
      if (res.statusCode == 200) {
        List<dynamic> resData = jsonDecode(res.body);
        setState(() {
          optShift = resData;
        });
        return optShift;
      } else {
        mainService.errorHandling(res, context);
      }
    });
  }

  selectedShift(value) {
    var nameShift =
        optShift.where((element) => element['id'] == value).toList();

    setState(() {
      selectedItem = value as String?;
      selectedName = nameShift[0]['name'];
    });
  }

  addShift() {
    Map<String, dynamic> data = {
      'shiftStartDate': this.shiftStartDate,
      'shiftEndDate': this.shiftEndDate,
      'shiftId': this.selectedItem,
      'shiftName': this.selectedName,
    };
    return Navigator.of(context).pop(data);
    // return data;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: MediaQuery.of(context).size.height - 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  'Shift Change',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              child: Text(
                'Your requested date(s) is..',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    child: Text(
                      'From',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 130,
                    child: Text(
                      'To',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextDate(
                    onClick: () {
                      selectedDate('start');
                    },
                    ctrl: startDate,
                  ),
                  Container(
                    width: 20,
                    child: Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                  TextDate(
                    onClick: () {
                      selectedDate('end');
                    },
                    ctrl: endDate,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              child: Text(
                'Choose your new shift for selected date(s)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              height: 70,
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: 'Select Shift',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                items: optShift.map((element) {
                  return DropdownMenuItem(
                    child: Text(element['name']),
                    value: element['id'],
                  );
                }).toList(),
                onChanged: (value) {
                  selectedShift(value);
                },
                value: selectedItem,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // return null;
                        },
                        child: Text('CANCEL'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        )),
                  ),
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: addShift,
                      child: Text(widget.action == 'add' ? 'ADD' : 'EDIT'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
