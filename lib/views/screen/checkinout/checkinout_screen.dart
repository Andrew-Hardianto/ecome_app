import 'dart:convert';
// import 'dart:html';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/views/screen/checkinout/checkinout_service.dart';
import 'package:ecome_app/views/screen/widget/map/google_map_screen.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecome_app/utils/extension.dart';
import 'package:location/location.dart';

class CheckinoutScreen extends StatefulWidget {
  static const String routeName = '/check-in-out';
  const CheckinoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckinoutScreen> createState() => _CheckinoutScreenState();
}

class _CheckinoutScreenState extends State<CheckinoutScreen> {
  final checkinoutService = CheckInOutService();
  final mainService = MainService();
  List<dynamic> purposeList = [];
  final TextEditingController _remarks = TextEditingController();

  int groupValue = 0;
  bool userLoc = false;
  Location _location = Location();

  double lat = 0.0;
  double lng = 0.0;

  String? selectedItem;
  var dataType;

  @override
  void initState() {
    super.initState();
    checkinoutService.getLocation(context);
    getPurpose(context);
  }

  getPurpose(BuildContext context) async {
    final url = await mainService.urlApi() +
        '/api/v1/lookup/globalkey?name=TM_CHECKINOUT_PURPOSES';

    await mainService.getUrl(url, (res) {
      if (res.statusCode == 200) {
        List<dynamic> resData = jsonDecode(res.body);
        setState(() {
          purposeList = resData;
        });
        return purposeList;
      } else {
        mainService.errorHandling(res, context);
      }
    });
  }

  submitData(BuildContext context) async {
    await _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        lat = currentLocation.latitude!;
        lng = currentLocation.longitude!;
      });
    });

    final strBytesLat = utf8.encode(lat.toString());
    final base64Lat = base64.encode(strBytesLat);
    final strBytesLng = utf8.encode(lng.toString());
    final base64Lng = base64.encode(strBytesLng);

    Map<String, dynamic> formData = {
      "actualLatEnc": base64Lat,
      "actualLngEnc": base64Lng,
      "outOfOffice": userLoc,
      "purpose": !userLoc ? '' : selectedItem,
      "remark": !userLoc ? 'In The Office' : _remarks.text,
      "type": dataType['type'] == 'Check In' ? 'CHECKIN' : 'CHECKOUT'
    };

    checkinoutService.submitCheckinout(context, formData);
  }

  @override
  Widget build(BuildContext context) {
    dataType =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final type = dataType['type'];

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
              // Container(
              //   height: 200,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10.0),
              //   ),
              //   child: MapScreen(),
              // ),
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
                    setState(() {
                      groupValue = val as int;
                      if (val == 1) {
                        userLoc = true;
                      } else {
                        userLoc = false;
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
                        items: purposeList.map((element) {
                          return DropdownMenuItem(
                            child: Text(element['name']),
                            value: element['value'],
                          );
                        }).toList(),
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            selectedItem = value as String?;
                          });
                          print(value);
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
                        controller: _remarks,
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
                  onPressed: () {
                    submitData(context);
                  },
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
