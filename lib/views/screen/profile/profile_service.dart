import 'dart:convert';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/models/user.dart';
import 'package:ecome_app/provider/user_provider.dart';
import 'package:ecome_app/views/screen/changepassword/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileService {
  final mainService = MainService();
  var randomColor;

  getProfile(BuildContext context) async {
    var url = await mainService.urlApi() + '/api/v1/user/profile-detail';

    data(res) async {
      if (res.statusCode == 200) {
        var profile = jsonDecode(res.body);
        // var userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.setUser(res.body);
        print({'profile-detail': profile});
        randomColor = await mainService.getRandomColor();
      } else {
        mainService.errorHandling(res, context);
      }
    }

    mainService.getUrl(url, (res) => data(res));
  }

  final List<ProfileSettingMenu> menuList = [
    ProfileSettingMenu(
      menuIcon: Icon(Icons.lock),
      name: 'Password',
      url: ChangePasswordScreen.routeName,
    ),
    ProfileSettingMenu(
      menuIcon: Icon(Icons.pin),
      name: 'Pin',
      url: '/change-password',
    ),
    ProfileSettingMenu(
      menuIcon: Icon(Icons.facebook),
      name: 'Social Media',
      url: '/social-media',
    ),
    ProfileSettingMenu(
      menuIcon: Icon(Icons.dark_mode),
      name: 'Dark Mode',
      url: '',
    ),
    ProfileSettingMenu(
      menuIcon: Icon(Icons.login_outlined),
      name: 'Check In',
      url: '',
    ),
    ProfileSettingMenu(
      menuIcon: Icon(Icons.logout_outlined),
      name: 'Check Out',
      url: '',
    ),
  ];
}
