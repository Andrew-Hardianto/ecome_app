import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({Key? key}) : super(key: key);

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  Future copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: 'App Version'));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            height: 250,
            padding: EdgeInsets.only(left: 20, top: 70, right: 20, bottom: 10),
            margin: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 10),
                    blurRadius: 10,
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    copyToClipboard();
                  },
                  child: Text(
                    'New Version Realeased!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Update your app to enjoy our newest fatures',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      // https://play.google.com/store/apps/details?id=com.git.sc
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Install Now ',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 10,
            right: 10,
            top: 0,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                child: Image.asset("assets/images/new-version.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
