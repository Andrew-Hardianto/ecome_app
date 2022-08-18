import 'dart:convert';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/views/screen/bottom_navbar.dart';
import 'package:ecome_app/views/screen/widget/action-modal/modal_delete.dart';
import 'package:ecome_app/views/screen/widget/add-shift-change/add_shift_change.dart';
import 'package:ecome_app/views/screen/widget/snackbar_error.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ecome_app/utils/extension.dart';
import 'package:intl/intl.dart';

class ShiftChangeScreen extends StatefulWidget {
  static const String routeName = '/shift-change';
  const ShiftChangeScreen({Key? key}) : super(key: key);

  @override
  State<ShiftChangeScreen> createState() => _ShiftChangeScreenState();
}

class _ShiftChangeScreenState extends State<ShiftChangeScreen> {
  final mainService = MainService();
  TextEditingController remark = TextEditingController();

  List<dynamic> shiftList = [];
  List<dynamic> finalShiftList = [];
  bool drag = false;

  @override
  void initState() {
    super.initState();
  }

  addShift(action, int? index) {
    showDialog(
        context: context,
        builder: (context) {
          return AddShiftChange(
            action: action,
            data: action == 'add' ? null : shiftList[index!],
          );
        }).then((value) {
      print(value);
      if (value != null) {
        if (action == 'add') {
          setState(() {
            shiftList.add(value);
          });
        } else {
          setState(() {
            shiftList[index!] = value;
          });
        }
      }
    });
  }

  void deleteShift(int index) {
    setState(() {
      shiftList.removeAt(index);
    });
  }

  Future submit() async {
    shiftList.forEach((element) {
      finalShiftList.add({
        'scheduleDateFrom':
            DateFormat('yyyy-MM-dd').format(element['shiftStartDate']),
        'scheduleDateTo':
            DateFormat('yyyy-MM-dd').format(element['shiftEndDate']),
        'shiftId': element['shiftId'],
      });
    });

    Map<String, dynamic> payload = {
      'remark': remark.text,
      'details': finalShiftList
    };
    // print(payload);
    var url = await mainService.urlApi() + '/api/v1/user/tm/changeshift';

    mainService.postUrlApi(url, payload, (res) {
      if (res.statusCode == 200) {
        finalShiftList.clear();
        shiftList.clear();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => BottomNavbar()))
            .whenComplete(() {
          SnackBarSuccess(context, res['message']);
        });
      } else {
        finalShiftList.clear();
        mainService.errorHandling(res, context);
      }
    });
  }

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
                  controller: remark,
                  onChanged: (value) {
                    setState(() {
                      print(value);
                    });
                  },
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
                      addShift('add', null);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
              ),
              if (shiftList.length != 0 || shiftList.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: shiftList.asMap().entries.map((e) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: const DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    addShift('edit', e.key);
                                  },
                                  backgroundColor: Color(0xFF21B7CA),
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                ),
                                SlidableAction(
                                  onPressed: (context) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ModalDelete(
                                            deleteAction: () {
                                              deleteShift(e.key);
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        });
                                    ;
                                  },
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
                                  border:
                                      Border.all(color: '#C0C0C0'.toColor()),
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
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Shift Change ${e.key + 1}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: '#F2F2F2'.toColor(),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          '${DateFormat('dd MMM yyyy').format(e.value['shiftStartDate'])} - ${DateFormat('dd MMM yyyy').format(e.value['shiftEndDate'])}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text('${e.value['shiftName']}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()),
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
                    onPressed: shiftList.length == 0 ||
                            shiftList.isEmpty ||
                            remark.text == ''
                        ? null
                        : () {
                            submit();
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5);
                          else if (states.contains(MaterialState.disabled))
                            return Colors.green.shade100;
                          return Colors.green; // Use the component's default.
                        },
                      ),
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
