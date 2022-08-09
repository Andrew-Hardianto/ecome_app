import 'dart:convert';
import 'dart:typed_data';
import 'package:ecome_app/utils/snackbar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:ecome_app/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  // function store image

  _uploadImageToStorage(Uint8List? image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
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

    try {
      if (full_name.isNotEmpty &&
          username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String downloadUrl = await _uploadImageToStorage(image);

        await firebaseFirestore.collection('users').doc(cred.user!.uid).set({
          'fullName': full_name,
          'username': username,
          'email': email,
          'image': downloadUrl,
        });

        res = 'success';
      } else {
        res = 'please fields must not be empty!';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        res = 'Email already taken!';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // function login user

  loginUser(
    String email,
    String password,
  ) async {
    String res = '';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'please fields must not be empty!';
      }
      return res;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        res = 'Wrong password provided for that email';
      } else if (e.code == 'invalid-email') {
        res = 'No user found for that email';
      }
    } catch (e) {
      res = e.toString();
    }
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
    try {
      if (email.isNotEmpty) {
        await firebaseAuth.sendPasswordResetEmail(email: email);
        res = 'success';
      } else {
        res = 'Field email must not be empty!';
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-email') {
        res = 'No user found for that email';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
