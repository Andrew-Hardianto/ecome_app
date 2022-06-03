import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecome_app/views/screen/cart_screen.dart';
import 'package:ecome_app/views/screen/feed_screen.dart';
import 'package:ecome_app/views/screen/home_screen.dart';
import 'package:ecome_app/views/screen/profile_screen.dart';
import 'package:ecome_app/views/screen/search_screen.dart';
import 'package:ecome_app/views/screen/upload_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// pages
List pages = [
  HomeScreeen(),
  FeedScreen(),
  SearchScreen(),
  CartScreen(),
  UploadScreen(),
  ProfileScreen()
];

// Color style
var backgroundColor = Colors.black;
var buttonColor = Colors.black;
var textButtonColor = Colors.white;

// FIrebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseFirestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;
