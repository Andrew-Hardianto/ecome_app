import 'dart:convert';

import 'package:ecome_app/const.dart';
import 'package:ecome_app/controllers/auth_controllers.dart';
import 'package:ecome_app/controllers/main_service.dart';
import 'package:ecome_app/utils/snackbar.dart';
import 'package:ecome_app/views/screen/auth/forgot_password_screen.dart';
import 'package:ecome_app/views/screen/auth/sign_up.dart';
import 'package:ecome_app/views/screen/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var mainService = MainService();
  final LocalAuthentication auth = LocalAuthentication();
  bool check = false;

  bool hidePassword = true;
  bool isLoading = false;
  String allV = '';

  @override
  void initState() {
    super.initState();
    checkFingerPrint();
  }

  Future checkFingerPrint() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    setState(() {
      check = canAuthenticate;
    });
  }

  openFinger() async {
    if (check)
      try {
        final bool didAuthenticate = await auth.authenticate(
            authMessages: [
              AndroidAuthMessages(
                signInTitle: 'Fingerprint Authentication',
                cancelButton: 'Batal',
              ),
              IOSAuthMessages(cancelButton: 'Batal')
            ],
            localizedReason: 'Please authenticate to show account balance',
            options: const AuthenticationOptions(
              useErrorDialogs: false,
              biometricOnly: true,
            ));
        print(didAuthenticate);
      } on PlatformException catch (e) {
        print(e);
      }
  }

  Future submitLogin() async {
    setState(() {
      isLoading = true;
    });

    final res = await AuthController().signIn(
      _emailController.text,
      _passwordController.text,
    );
    var data = jsonDecode(res.body);

    setState(() {
      isLoading = false;
    });

    if (res.statusCode == 200) {
      final jwtData = jwtDecode(data['access_token']);

      Map<String, dynamic> keyJson = {
        "tenantId": jwtData.payload['tenant_id'][0],
        "urlApi": jwtData.payload['instance_api'][0],
        "accessToken": data['access_token']
      };

      mainService.saveStorage('ACT@KN2', data['access_token']);
      mainService.saveStorage('RF@S!TK', data['refresh_token']);
      mainService.saveStorage('SPS!#WU', jsonEncode(keyJson));
      mainService.saveStorage('G!T@FTR', mainService.saveRandomColor());

      _emailController.clear();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => BottomNavbar()));
    } else {
      return showSnackbarError(data['error_description'], context);
    }
  }

  // const LoginScreen({
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _passwordController,
              obscureText: hidePassword,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Enter your password',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      hidePassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 110,
                child: ElevatedButton(
                  onPressed: () {
                    submitLogin();
                    _passwordController.clear();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Login',
                          style: TextStyle(
                            color: textButtonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                ),
              ),
              SizedBox(
                width: 60,
                child: ElevatedButton(
                  onPressed: () {
                    openFinger();
                  },
                  child: Icon(Icons.fingerprint_rounded),
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                ),
              )
            ]),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account ?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ForgotPasswordScreen()));
              },
              child: Text(
                'Forgot Password ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
