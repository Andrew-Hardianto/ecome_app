import 'dart:convert';
import 'dart:typed_data';
import 'package:ecome_app/utils/snackbar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:ecome_app/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';

class AuthController {
// http
  static var client = http.Client();

  // Header
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  // Create storage
  final storage = new FlutterSecureStorage();

  saveStorage(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  // function pick image
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('no image selected');
    }
  }

  // function signup users

  Future<String> signUpUsers(
    String full_name,
    String username,
    String email,
    String password,
    Uint8List? image,
  ) async {
    String res = 'some error occured';
    return res;
  }

  // function login user

  loginUser(
    String email,
    String password,
  ) async {
    String res = '';
  }

  // login user
  signIn(String email, String password) async {
    var res;
    // Body
    Map<String, String> bodyData = {
      'grant_type': 'password',
      'client_id': 'git-client',
      'username': email,
      'password': password
    };

    final url = Uri.parse(
        'https://keycloak-dev.gitsolutions.id/auth/realms/GIT/protocol/openid-connect/token');

    try {
      var resp = await http.post(url, headers: requestHeaders, body: bodyData);

      return res = resp;
    } catch (e) {
      return res = e;
    }
  }

// function fotgot password
  forgotPassword(String email) async {
    String res = '';
  }
}
