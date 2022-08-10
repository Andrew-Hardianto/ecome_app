import 'dart:convert';
// import 'dart:html';
import 'dart:math';

import 'package:ecome_app/provider/theme_provider.dart';
import 'package:ecome_app/views/screen/widget/snackbar_error.dart';
import 'package:encrypt/encrypt.dart' as encrypts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MainService {
  static var client = http.Client();

  // Header
  Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

  var key = encrypts.Key.fromUtf8('1234567890987654');
  var iv = encrypts.IV.fromUtf8('1234567890987654');
  final storage = new FlutterSecureStorage();
  final _random = new Random();

  var colors = [
    "#FF757D",
    "#52EED2",
    "#FF6996",
    "#1AD4D4",
    "#FF7AB2",
    "#0FEDFB",
    "#FF8933",
    "#3BCAF8",
    "#FFB74A",
    "#3AA1FF",
    "#F8D042",
    "#3969E4",
    "#EED496",
    "#9AAFFB",
    "#DEB792",
    "#C4B6ED",
    "#6AEE8F",
    "#9A7EEC",
    "#0AD98E",
    "#E49FEA"
  ];

  urlApi() async {
    final String? keyJson = await storage.read(key: 'SPS!#WU');
    if (keyJson != null) {
      final url = jsonDecode(keyJson)['urlApi'];
      return url;
    }
  }

  encrypt(String plainText) {
    final encrypter = encrypts.Encrypter(encrypts.AES(key));

    final encryptedStr = encrypter.encrypt(plainText, iv: iv);
    return encryptedStr.base16.toString();
  }

  decrypt(plainText) {
    final encrypter = encrypts.Encrypter(encrypts.AES(key));
    if (plainText != null) {
      final decrypted = encrypter.decrypt16(plainText, iv: iv);
      return decrypted;
    } else {
      return null;
    }
  }

  saveStorage(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  getRandomColor() async {
    final allValues = await storage.read(key: 'G!T@FTR');
    final decr = decrypt(allValues);
    return decr;
  }

  saveRandomColor() {
    final randomColorAvatar = colors[_random.nextInt(colors.length)];
    final color = encrypt(randomColorAvatar);
    return color;
  }

  getAuthoritiesToken() {}

  getAccessToken() async {
    final String? keyJson = await storage.read(key: 'SPS!#WU');
    final url = jsonDecode(keyJson!)['accessToken'];
    return url.toString();
  }

  getTenantId() async {
    final String? keyJson = await storage.read(key: 'SPS!#WU');
    final url = jsonDecode(keyJson!)['tenantId'];
    return url.toString();
  }

  getUrl(String url, Function callback) async {
    // Body
    Map<String, String> bodyData = {
      'X-TenantID': await this.getTenantId(),
      'Authorization': 'Bearer ' + await this.getAccessToken(),
      "AuthorizationToken": await this.getAuthoritiesToken() ?? ''
    };

    var res = await http
        .get(Uri.parse(url), headers: bodyData)
        .then((data) => callback(data));
    // .catchError((err) => print(err));

    return res;
  }

  void errorHandling(dynamic res, BuildContext context) {
    var err = jsonDecode(res.body)["error_description"];
    var msg = jsonDecode(res.body)["message"];
    if (res.statusCode == 401 || res.statusCode == 400) {
      if (msg != "") {
        print(msg);
        SnackBarError(context, msg);
      } else {
        print(err);
        SnackBarError(context, err);
      }
    } else {
      SnackBarError(context, "Can\'t connect to server. Please Contact Admin!");
    }
    print(res.body);
  }

  getDarkMode(BuildContext ctx) {
    final bool darkMode =
        Provider.of<ThemeProvider>(ctx).themeMode == ThemeMode.dark
            ? true
            : false;
    return darkMode;
  }
}
