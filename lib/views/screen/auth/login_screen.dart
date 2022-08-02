import 'dart:convert';

import 'package:ecome_app/const.dart';
import 'package:ecome_app/controllers/auth_controllers.dart';
import 'package:ecome_app/utils/snackbar.dart';
import 'package:ecome_app/views/screen/auth/forgot_password_screen.dart';
import 'package:ecome_app/views/screen/auth/sign_up.dart';
import 'package:ecome_app/views/screen/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = new FlutterSecureStorage();

  bool hidePassword = true;
  bool isLoading = false;
  String allV = '';

  @override
  void initState() {
    super.initState();
    // getStorage();
  }

  getStorage() async {
    final allValues = await storage.read(key: 'SPS!#WU');
    print(allValues);
    return allV = allValues!;
  }

  submitLogin() async {
    setState(() {
      isLoading = true;
    });

    // String res = await AuthController().loginUser(
    //   _emailController.text,
    //   _passwordController.text,
    // );

    final res = await AuthController().signIn(
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    print(res);

    // if (res != 'success') {
    // return showSnackbarError(res!, context);
    // } else {
    //   _emailController.clear();
    //   Navigator.of(context).push(
    //       MaterialPageRoute(builder: (BuildContext context) => BottomNavbar()));
    // }
    _emailController.clear();
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
