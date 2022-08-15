import 'dart:convert';
import 'dart:io';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/views/screen/checkinout/checkinout_service.dart';
import 'package:ecome_app/views/screen/widget/map/google_map_screen.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecome_app/utils/extension.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

  bool takePhoto = false;
  File? image;

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

  showBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.3,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        pickImage()
                            .whenComplete(() => Navigator.of(context).pop());
                      },
                      child: Text(
                        'Take a Picture',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: image == null
                              ? new BorderRadius.circular(10.0)
                              : new BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                ),
                        ),
                      ),
                    ),
                  ),
                  if (image != null)
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            image = null;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Delete Picture',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.only(
                              topRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

// take photo
  Future pickImage() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.camera);
      if (img == null) return;
      setState(() {
        image = File(img.path);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
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
              Card(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Take a photo!'),
                          Switch(
                              value: takePhoto,
                              onChanged: (v) {
                                setState(() {
                                  takePhoto = v;
                                });
                              })
                        ],
                      ),
                      if (takePhoto)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey.shade200,
                            border: Border.all(
                              color: Colors.grey,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              showBottomSheet(context);
                            },
                            child: image == null
                                ? Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.camera_enhance,
                                        size: 48,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        'Take Photo',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  )
                                : Image.file(image!),
                          ),
                        )
                    ],
                  ),
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
