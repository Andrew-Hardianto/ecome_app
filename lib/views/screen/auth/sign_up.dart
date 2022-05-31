import 'package:ecome_app/const.dart';
import 'package:ecome_app/views/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage('profilePic'),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 10,
                    child: Icon(Icons.add_a_photo),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter your full name',
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
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Enter your username',
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
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
                      'Register',
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
                    'Already have an account ?',
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
                          builder: (context) => LoginScreen()));
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
      ),
    );
  }
}
