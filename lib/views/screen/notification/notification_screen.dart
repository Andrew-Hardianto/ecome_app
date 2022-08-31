import 'dart:io';

import 'package:ecome_app/controllers/notification.dart';
import 'package:ecome_app/views/screen/bottom_navbar.dart';
import 'package:ecome_app/views/screen/widget/text_appbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showcaseview/showcaseview.dart';

class NotifShowcase extends StatelessWidget {
  const NotifShowcase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) => NotifScreen(),
      ),
    );
  }
}

class NotifScreen extends StatefulWidget {
  static const String routeName = '/notification';
  const NotifScreen({Key? key}) : super(key: key);

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  final TextEditingController _test = TextEditingController();
  final _key1 = GlobalKey();
  final _key2 = GlobalKey();
  final _key3 = GlobalKey();

  File? file;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ShowCaseWidget.of(context).startShowCase([_key1, _key2, _key3]);
    });
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

  upload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    print(result);
    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
        print(file?.readAsBytesSync());
      });
    }
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
              child: Showcase(
                key: _key1,
                description: 'Press button to send notification',
                shapeBorder: const RoundedRectangleBorder(),
                showcaseBackgroundColor: Colors.indigo,
                descTextStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                blurValue: 0.0,
                child: ElevatedButton(
                  child: Text('Send Notification'),
                  onPressed: () => NotificationApi.showNotification(
                    title: 'Check In',
                    body: 'Your request hasbeen submit',
                    payload: 'request id',
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Showcase(
                key: _key2,
                description: 'Type text your want copy here',
                showcaseBackgroundColor: Colors.indigo,
                blurValue: 0.0,
                child: TextField(
                  controller: _test,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: Showcase(
                key: _key3,
                description: 'Press button to copy text',
                shapeBorder: const RoundedRectangleBorder(),
                showcaseBackgroundColor: Colors.indigo,
                descTextStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                blurValue: 0.0,
                child: ElevatedButton(
                  child: Text('Copy'),
                  onPressed: copyText,
                ),
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
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              height: 50,
              child: file != null
                  ? Icon(
                      Icons.article,
                      size: 40,
                    )
                  : Icon(
                      Icons.article_outlined,
                      size: 40,
                    ),
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                child: Text('Upload'),
                onPressed: () {
                  upload();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
