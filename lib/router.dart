import 'package:ecome_app/views/screen/calendar/calendar_screen.dart';
import 'package:ecome_app/views/screen/camera/camera_screen.dart';
import 'package:ecome_app/views/screen/checkinout/checkinout_screen.dart';
import 'package:ecome_app/views/screen/notification/notification_screen.dart';
import 'package:ecome_app/views/screen/shiftchange/shift_change_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecome_app/views/screen/changepassword/change_password_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case ChangePasswordScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ChangePasswordScreen(),
      );
    case CheckinoutScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CheckinoutScreen(),
      );
    case ShiftChangeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ShiftChangeScreen(),
      );
    case CalendarScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CalendarScreen(),
      );
    case CameraScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CameraScreen(),
      );
    case NotifScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotifShowcase(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Page not found!'),
          ),
        ),
      );
  }
}
