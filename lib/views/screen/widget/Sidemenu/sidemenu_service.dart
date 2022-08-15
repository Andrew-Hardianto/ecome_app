import 'package:ecome_app/models/menulist.dart';
import 'package:ecome_app/views/screen/checkinout/checkinout_screen.dart';
import 'package:ecome_app/views/screen/shiftchange/shift_change_screen.dart';
import 'package:flutter/material.dart';

class SidemenuService {
  final List<MenuList> menuList = [
    MenuList(
      menuIcon: Icon(Icons.bar_chart),
      name: 'Status',
      url: '',
    ),
    MenuList(
      menuIcon: Icon(Icons.login_outlined),
      name: 'Check In',
      url: CheckinoutScreen.routeName,
    ),
    MenuList(
      menuIcon: Icon(Icons.logout_outlined),
      name: 'Check Out',
      url: CheckinoutScreen.routeName,
    ),
    MenuList(
      menuIcon: Icon(Icons.change_history),
      name: 'Shift Change',
      url: ShiftChangeScreen.routeName,
    ),
  ];
}
