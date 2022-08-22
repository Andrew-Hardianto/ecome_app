import 'package:ecome_app/models/menulist.dart';
import 'package:ecome_app/views/screen/checkinout/checkinout_screen.dart';
import 'package:ecome_app/views/screen/face-detection/face_detection_screen.dart';
import 'package:ecome_app/views/screen/notification/notification_screen.dart';
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
    // MenuList(
    //   menuIcon: Icon(Icons.face_outlined),
    //   name: 'Face Detection',
    //   url: FaceDetectionScreen.routeName,
    // ),
    MenuList(
      menuIcon: Icon(Icons.notification_important_outlined),
      name: 'Notification',
      url: NotifScreen.routeName,
    ),
  ];
}
