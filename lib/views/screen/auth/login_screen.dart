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
import 'package:flutter/src/widgets/framework.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var mainService = MainService();

  bool hidePassword = true;
  bool isLoading = false;
  String allV = '';

  @override
  void initState() {
    super.initState();
  }

  submitLogin() async {
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

    print({'status', res.body});

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

    isLoading = false;
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
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(color: buttonColor),
              child: Center(
                child: InkWell(
                  onTap: () {
                    submitLogin();
                    _passwordController.clear();
                  },
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
            ),
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
