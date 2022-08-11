import 'dart:ui';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/provider/user_provider.dart';
import 'package:ecome_app/utils/extension.dart';
import 'package:ecome_app/views/screen/profile/profile_service.dart';
import 'package:ecome_app/views/screen/widget/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // const ProfileScreen({Key? key}) : super(key: key);
  final profileService = ProfileService();
  final mainService = MainService();
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
    var dark = mainService.getDarkMode(context);

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
                      user.profilePicture != null
                          ? CircleAvatar(
                              backgroundColor: Colors.white70,
                              minRadius: 60.0,
                              backgroundImage:
                                  NetworkImage(user.profilePicture!),
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
                                user.alias == null ? '-' : user.alias!,
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
                    user.fullName != null ? user.fullName! : '-',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    user.positionName != null ? user.positionName! : '-',
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 370,
                    child: ListView(
                      children: profileService.menuList.map((e) {
                        return Container(
                          height: 60.0,
                          child: GestureDetector(
                            onTap: () {
                              e.url == ''
                                  ? ''
                                  : Navigator.of(context).pushNamed(e.url);
                            },
                            child: Card(
                              elevation: 5,
                              color: dark ? '#121212'.toColor() : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              shadowColor: dark ? Colors.white : Colors.black,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 20.0,
                                ),
                                child: Row(
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
                                    e.name == 'Dark Mode'
                                        ? ChangeThemeButtonWidget()
                                        : Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
