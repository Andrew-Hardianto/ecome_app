import 'dart:typed_data';

import 'package:ecome_app/const.dart';
import 'package:ecome_app/controllers/auth_controllers.dart';
import 'package:ecome_app/utils/snackbar.dart';
import 'package:ecome_app/views/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool hidePassword = true;
  bool isLoading = false;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;

  selectedImage() async {
    Uint8List im = await AuthController().pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  signUpUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthController().signUpUsers(
        _fullNameController.text,
        _userNameController.text,
        _emailController.text,
        _passwordController.text,
        _image);

    setState(() {
      isLoading = false;
    });

    if (res != 'success') {
      return showSnackbarError(res, context);
    } else {
      _fullNameController.clear();
      _userNameController.clear();
      _emailController.clear();
      _image!.clear();
      return showSnackbarSuccess(
          'Congratulations account has been created', context);
    }
  }

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
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.blue,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.blue,
                          backgroundImage: NetworkImage(
                              'https://res.cloudinary.com/andrew92/image/upload/v1627267361/bookit/avatars/wzo8vufntfgd2oyyzp0n.png'),
                        ),
                  Positioned(
                    right: 5,
                    bottom: 10,
                    child: InkWell(
                        onTap: selectedImage, child: Icon(Icons.add_a_photo)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _fullNameController,
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
                controller: _userNameController,
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
                      signUpUser();
                      _passwordController.clear();
                    },
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
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
                      'Sign In',
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
