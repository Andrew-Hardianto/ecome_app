import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'dart:html';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:ecome_app/provider/theme_provider.dart';
import 'package:ecome_app/views/screen/widget/snackbar_error.dart';
import 'package:encrypt/encrypt.dart' as encrypts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:provider/provider.dart';

class MainService {
  static var client = http.Client();
  var dio = Dio();

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

  deleteStorage(String key) async {
    await storage.delete(key: key);
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

  getAuthoritiesToken() async {
    final profile = await storage.read(key: 'AU@HZS!');
    if (profile != null) {
      final token = jsonDecode(profile)['authoritiesToken'];
      // let authToken: any = jwt_decode(profile.authoritiesToken);
      final authToken = jwtDecode(token);
      return authToken.payload['authorities'];
    } else {
      return null;
    }
  }

  getAccessToken() async {
    final String? keyJson = await storage.read(key: 'SPS!#WU');
    if (keyJson != null) {
      final url = jsonDecode(keyJson)['accessToken'];
      return url;
    } else {
      return null;
    }
  }

  Future<bool?> tokenExpired() async {
    final token = await getAccessToken();
    final decodeToken = jwtDecode(token);
    return await decodeToken.isExpired;
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
    };

    var res = await http
        .get(Uri.parse(url), headers: bodyData)
        .timeout(
          Duration(milliseconds: 35000),
          onTimeout: () => http.Response(
            'message',
            408,
          ),
        )
        .then((data) => callback(data));

    return res;
  }

  postUrlApi(String urlApi, formData, Function callback) async {
    Map<String, String> headers = {
      'X-TenantID': await this.getTenantId(),
      'Authorization': 'Bearer ' + await this.getAccessToken(),
      "content-type": "application/json"
    };

    var res = await http
        .post(Uri.parse(urlApi), headers: headers, body: jsonEncode(formData))
        .timeout(Duration(milliseconds: 35000))
        .then((data) => callback(data));

    return res;
  }

  postFormDataUrlApi(String urlApi, data, Function callback) async {
    Map<String, String> headers = {
      'X-TenantID': await this.getTenantId(),
      'Authorization': 'Bearer ' + await this.getAccessToken(),
    };

    try {
      var formData = FormData.fromMap(data);

      var res = await dio.post(
        urlApi,
        data: formData,
        options: Options(headers: headers, sendTimeout: 35000),
      );

      // var res = await http
      //     .post(Uri.parse(urlApi), headers: headers, body: formData)
      //     .timeout(Duration(milliseconds: 35000))
      //     .then((data) => callback(data));

      return callback(res);
    } on DioError catch (e) {
      callback(e);
    }
  }

  void errorHandling(dynamic res, BuildContext context) {
    if (res.statusCode == 401 || res.statusCode == 400) {
      if (res.body != '') {
        var msg = jsonDecode(res.body)["message"];
        var err = jsonDecode(res.body)["error_description"];
        if (msg != "") {
          SnackBarError(context, msg);
        } else {
          SnackBarError(context, err);
        }
      }
      SnackBarError(context, "Can\'t connect to server. Please Contact Admin!");
    } else {
      SnackBarError(context, "Can\'t connect to server. Please Contact Admin!");
    }
  }

  void errorHandlingDio(dynamic res, BuildContext context) {
    if (res.response.statusCode == 401 || res.response.statusCode == 400) {
      var msg = jsonDecode(res.response);
      if (msg == '') {
        SnackBarError(context, msg);
      } else {
        SnackBarError(
            context, "Can\'t connect to server. Please Contact Admin!");
      }
    } else {
      SnackBarError(context, "Can\'t connect to server. Please Contact Admin!");
    }
  }

  getDarkMode(BuildContext ctx) {
    final bool darkMode =
        Provider.of<ThemeProvider>(ctx).themeMode == ThemeMode.dark
            ? true
            : false;
    return darkMode;
  }
}
