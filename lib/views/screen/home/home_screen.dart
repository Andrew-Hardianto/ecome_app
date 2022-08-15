import 'dart:convert';

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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecome_app/utils/extension.dart';

class HomeScreeen extends StatefulWidget {
  // const HomeScreeen({Key? key}) : super(key: key);
  @override
  State<HomeScreeen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreeen> {
  var mainService = MainService();
  var homeService = HomeService();

  var url;

  @override
  void initState() {
    super.initState();
    homeService.getProfile(context);
    homeService.checkAppVersion(context);
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
