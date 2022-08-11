import 'dart:convert';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/models/menulist.dart';
import 'package:ecome_app/views/screen/changepassword/change_password_screen.dart';
import 'package:flutter/material.dart';

class ProfileService {
  final mainService = MainService();
  var randomColor;

  getProfile(BuildContext context) async {
    var url = await mainService.urlApi() + '/api/v1/user/profile-detail';

    data(res) async {
      if (res.statusCode == 200) {
        var profile = jsonDecode(res.body);
        print({'profile-detail': profile});
        randomColor = await mainService.getRandomColor();
      } else {
        mainService.errorHandling(res, context);
      }
    }

    mainService.getUrl(url, (res) => data(res));
  }

  final List<MenuList> menuList = [
    MenuList(
      menuIcon: Icon(Icons.lock),
      name: 'Password',
      url: ChangePasswordScreen.routeName,
    ),
    MenuList(
      menuIcon: Icon(Icons.pin),
      name: 'Pin',
      url: '/change-password',
    ),
    MenuList(
      menuIcon: Icon(Icons.facebook),
      name: 'Social Media',
      url: '/social-media',
    ),
    MenuList(
      menuIcon: Icon(Icons.dark_mode),
      name: 'Dark Mode',
      url: '',
    ),
  ];
}
