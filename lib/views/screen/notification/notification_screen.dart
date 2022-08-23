import 'package:ecome_app/controllers/notification.dart';
import 'package:ecome_app/views/screen/bottom_navbar.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotifScreen extends StatefulWidget {
  static const String routeName = '/notification';
  const NotifScreen({Key? key}) : super(key: key);

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  final TextEditingController _test = TextEditingController();

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

  copyText() {
    final data = ClipboardData(text: _test.text);
    Clipboard.setData(data);
  }

  pasteText() async {
    Clipboard.getData(Clipboard.kTextPlain).then((value) {
      print(value!.text); //value is clipbarod data
    });
  }

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
                  payload: 'request id',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _test,
              ),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                child: Text('Copy'),
                onPressed: copyText,
              ),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                child: Text('Paste'),
                onPressed: () {
                  pasteText();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
