import 'package:flutter/material.dart';
import 'package:ecome_app/utils/extension.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: '#121212'.toColor(),
    primaryColor: '#121212'.toColor(),
    colorScheme: ColorScheme.dark(),
    cardColor: '#121212'.toColor(),
    iconTheme: IconThemeData(color: Colors.white),
    shadowColor: Colors.white,
    backgroundColor: '#121212'.toColor(),
  );

  static final lightTheme = ThemeData(
    shadowColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.light(),
    cardColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
  );
}
