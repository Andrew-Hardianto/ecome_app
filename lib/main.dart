import 'package:ecome_app/const.dart';
import 'package:ecome_app/provider/products.dart';
import 'package:ecome_app/views/screen/auth/login_screen.dart';
import 'package:ecome_app/views/screen/bottom_navbar.dart';
import 'package:ecome_app/views/screen/detail/detail_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyDpsN1PB9NrQCd6G9F7KFZKYZcgM5WM4gU',
      appId: '1:50700194989:web:712c102e2b3a030868e224',
      messagingSenderId: "50700194989",
      projectId: "clothing-db-a092e",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecome App',
        // theme: ThemeData.light().copyWith(
        //   scaffoldBackgroundColor: Colors.white,
        // ),
        // home: LoginScreen(),
        home: BottomNavbar(),
        routes: {
          DetailPage.id: (context) => DetailPage(),
        },
      ),
    );
  }
}
