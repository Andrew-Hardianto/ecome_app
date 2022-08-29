import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:ecome_app/controllers/main_service.dart';
import 'package:flutter/material.dart';
import 'package:ecome_app/utils/extension.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final mainService = MainService();
  ReceivePort _port = ReceivePort();

  List<dynamic> regulationList = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      setState(() {
        int progress = data[2];
      });
      print({'data': data});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    getRegulation();
  }

  @override
  void dispose() {
    regulationList.clear();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  getRegulation() async {
    setState(() {
      isLoading = true;
    });
    var url = await mainService.urlApi() + '/api/v1/user/regulations';

    await mainService.getUrl(url, (res) {
      if (res.statusCode == 200) {
        setState(() {
          regulationList = jsonDecode(res.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        mainService.errorHandling(res, context);
      }
    });
  }

  downloadFile(url) async {
    final status = await Permission.storage.request();
    final folderDir = await getExternalStorageDirectory();

    if (status.isGranted) {
      final id = await FlutterDownloader.enqueue(
        url: url,
        savedDir: folderDir!.path,
        showNotification: true,
        fileName: 'dowload',
        // openFileFromNotification: true,
      );

      print(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var dark = mainService.getDarkMode(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            if (!isLoading)
              ListView(
                  children: regulationList.map((e) {
                return Container(
                  height: 60.0,
                  child: Card(
                    elevation: 5,
                    color: dark ? '#121212'.toColor() : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    shadowColor: dark ? Colors.white : Colors.black,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.file_open),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              e['name'],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.file_download),
                            onPressed: () {
                              downloadFile(e['path']);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()),
            if (isLoading)
              ListView(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey,
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      // color: Colors.black,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey,
                    child: Container(
                      width: double.infinity,
                      height: 60.0,
                      // color: Colors.black,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
