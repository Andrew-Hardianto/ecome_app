import 'dart:ui';

import 'package:ecome_app/provider/user_provider.dart';
import 'package:ecome_app/utils/extension.dart';
import 'package:ecome_app/views/screen/changepassword/change_password_screen.dart';
import 'package:ecome_app/views/screen/profile/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // const ProfileScreen({Key? key}) : super(key: key);
  final profileService = ProfileService();
  var randomColor;
  var name;

  @override
  void initState() {
    super.initState();
    profileService.getProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
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
                      // user.profilePicture != null || user.profilePicture != ''
                      user.profilePicture != ''
                          ? CircleAvatar(
                              backgroundColor: Colors.white70,
                              minRadius: 60.0,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage:
                                    NetworkImage(user.profilePicture),
                              ),
                            )
                          : Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: profileService.randomColor == null
                                    ? '#121212'.toColor()
                                    : '${profileService.randomColor}'.toColor(),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: Text(
                                user.alias,
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
                    user.fullName,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    user.positionName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: profileService.menuList.map((e) {
                    return Container(
                      height: 60.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(e.url);
                        },
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          shadowColor: Colors.black,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.,
                              children: <Widget>[
                                e.menuIcon,
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    e.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
