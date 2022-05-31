import 'package:ecome_app/const.dart';
import 'package:ecome_app/views/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecome App',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginScreen(),
    );
  }
}
