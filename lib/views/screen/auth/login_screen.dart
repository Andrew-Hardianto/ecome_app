import 'package:ecome_app/const.dart';
import 'package:ecome_app/views/screen/auth/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final String email;
  bool hidePassword = true;

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
                    print('wow');
                  },
                  child: Text(
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
            )
          ],
        ),
      ),
    );
  }
}
