import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/models/menulist.dart';
import 'package:ecome_app/views/screen/auth/login_screen.dart';
import 'package:ecome_app/views/screen/calendar/calendar_screen.dart';
import 'package:ecome_app/views/screen/camera/camera_screen.dart';
import 'package:ecome_app/views/screen/chart/chart_screen.dart';
import 'package:ecome_app/views/screen/checkinout/checkinout_screen.dart';
import 'package:ecome_app/views/screen/notification/notification_screen.dart';
import 'package:ecome_app/views/screen/shiftchange/shift_change_screen.dart';
import 'package:flutter/material.dart';

class SidemenuService {
  final mainService = MainService();

  final List<MenuList> menuList = [
    MenuList(
      menuIcon: Icon(Icons.bar_chart),
      name: 'Camera',
      url: CameraScreen.routeName,
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
    MenuList(
      menuIcon: Icon(Icons.notification_important_outlined),
      name: 'Notification',
      url: NotifScreen.routeName,
    ),
    MenuList(
      menuIcon: Icon(Icons.calendar_month),
      name: 'Calendar',
      url: CalendarScreen.routeName,
    ),
    MenuList(
      menuIcon: Icon(Icons.pie_chart_outline),
      name: 'Chart',
      url: ChartScreen.routeName,
    ),
  ];

  logout(BuildContext context) {
    mainService.deleteStorage('SPS!#WU');
    mainService.deleteStorage('AU@HZS!');
    mainService.deleteStorage('G!T@VTR');
    mainService.deleteStorage('ACT@KN2');
    mainService.deleteStorage('P@CKGN!');
    Future.delayed(Duration(milliseconds: 1000)).then((value) =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen())));
  }
}
