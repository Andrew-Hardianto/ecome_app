import 'dart:convert';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/utils/extension.dart';
import 'package:ecome_app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // const ProfileScreen({Key? key}) : super(key: key);
  var mainService = MainService();
  var randomColor;
  var profile;
  var name;

  String? profileImage;

  @override
  void initState() {
    super.initState();
    getColor();
    getProfile();
  }

  getColor() async {
    randomColor = await mainService.getRandomColor();
  }

  getProfile() async {
    var url = await mainService.urlApi() + '/api/v1/user/profile';

    data(res) {
      if (res.statusCode == 200) {
        profile = jsonDecode(res.body);
      } else {
        print(res.body);
      }
    }

    mainService.getUrl(url, (res) => data(res)
        // data = jsonDecode(res.statusCode),

        // if (res.statusCode == 200)
        //   {profile = res.body, name = profile.fullName}
        // else
        //   {showSnackbarError(res.body['error_description'], context)}
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Challenge 01',
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.deepOrange.shade300],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.5, 0.9],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      profileImage != null
                          ? CircleAvatar(
                              backgroundColor: Colors.white70,
                              minRadius: 60.0,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage:
                                    NetworkImage(profileImage.toString()),
                              ),
                            )
                          : Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                color: '#121212'.toColor(),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                'AS',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 48),
                              )),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'wdwd',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Flutter Developer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
