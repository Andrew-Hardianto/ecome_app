import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/provider/theme_provider.dart';
import 'package:ecome_app/views/screen/home/home_service.dart';
import 'package:ecome_app/views/screen/widget/Sidemenu/sidemenu.dart';
import 'package:ecome_app/views/screen/widget/all_products.dart';
import 'package:ecome_app/views/screen/widget/category.dart';
import 'package:ecome_app/views/screen/widget/category_list.dart';
import 'package:ecome_app/views/screen/widget/custom_app_bar.dart';
import 'package:ecome_app/views/screen/widget/searchbar.dart';
import 'package:ecome_app/views/screen/widget/tag.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecome_app/utils/extension.dart';
import 'package:device_info_plus/device_info_plus.dart';

class HomeScreeen extends StatefulWidget {
  // const HomeScreeen({Key? key}) : super(key: key);
  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  var mainService = MainService();
  var homeService = HomeService();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  var url;

  @override
  void initState() {
    super.initState();
    homeService.getProfile(context);
    homeService.checkAppVersion(context);

    // notif background on terminate onclick
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print({'initial msg': message.notification!.title});
      }
    });

    //  on background click
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(event.notification!.body);
    });

    getDeviceInfo();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  getDeviceInfo() async {
    final device = await deviceInfoPlugin.androidInfo;
    print(device.device);
    print(Platform.isAndroid);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      print(result);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool themeProvider = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider ? '#121212'.toColor() : Colors.white,
        iconTheme: themeProvider
            ? IconThemeData(color: Colors.white)
            : IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            Searchbar(),
            TagList(),
            Category(),
            CategoryList(),
            AllProducts(),
          ],
        ),
      ),
      drawer: SidemenuNavigation(),
    );
  }
}
