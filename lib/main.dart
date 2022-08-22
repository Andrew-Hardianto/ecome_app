import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/provider/map_provider.dart';
import 'package:ecome_app/provider/products.dart';
import 'package:ecome_app/provider/theme_provider.dart';
import 'package:ecome_app/provider/user_provider.dart';
import 'package:ecome_app/router.dart';
import 'package:ecome_app/views/screen/auth/login_screen.dart';
import 'package:ecome_app/views/screen/bottom_navbar.dart';
import 'package:ecome_app/views/screen/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<MapProvider>(
          create: (_) => MapProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainService = MainService();
    final themeProvider = Provider.of<ThemeProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecome App',
      themeMode: themeProvider.themeMode,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: mainService.getAccessToken() != null ||
              mainService.tokenExpired() == false
          ? BottomNavbar()
          : LoginScreen(),
      // home: BottomNavbar(),
      routes: {
        DetailPage.id: (context) => DetailPage(),
      },
    );
  }
}
