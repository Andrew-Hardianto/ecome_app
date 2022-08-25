import 'package:ecome_app/const.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  // const BottomNavbar({Key? key}) : super(key: key);
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    // foreground notif
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        print({'fg': event.notification!.title});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        currentIndex: pageIndex,
        activeColor: Colors.green,
        inactiveColor: Colors.white,
        backgroundColor: backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.rss_feed,
                size: 30,
              ),
              label: 'Feed'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
                size: 30,
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.upload,
                size: 30,
              ),
              label: 'Upload'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Profile'),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}
