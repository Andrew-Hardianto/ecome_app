import 'package:ecome_app/controllers/notification.dart';
import 'package:ecome_app/views/screen/bottom_navbar.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/material.dart';

class NotifScreen extends StatefulWidget {
  static const String routeName = '/notification';
  const NotifScreen({Key? key}) : super(key: key);

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  @override
  void initState() {
    super.initState();
    NotificationApi.init();
    listenNotification();
  }

  listenNotification() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BottomNavbar(),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: TextAppbar(text: 'Shift Change'),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: ElevatedButton(
                child: Text('Send Notification'),
                onPressed: () => NotificationApi.showNotification(
                    title: 'Check In',
                    body: 'Your request hasbeen submit',
                    payload: 'request id'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
