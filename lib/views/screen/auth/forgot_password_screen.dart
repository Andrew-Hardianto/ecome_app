import 'package:ecome_app/const.dart';
import 'package:ecome_app/controllers/auth_controllers.dart';
import 'package:ecome_app/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  submitForgotPassword() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthController().forgotPassword(_emailController.text);

    setState(() {
      isLoading = false;
    });

    if (res == 'success') {
      _emailController.clear();
      return showSnackbarSuccess('Link has been send to your email!', context);
    } else {
      print(res);
      return showSnackbarError(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Forgot Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
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
                child: GestureDetector(
                  onTap: submitForgotPassword,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: textButtonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
