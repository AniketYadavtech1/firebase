import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/talknest/auth/ui/login_screen.dart';
import 'package:flutter/material.dart';
import '../ui/firestore/firestore_list.screen.dart';

class SplashServices {
  void isLogin(BuildContext, context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FireStoreScreen(),
            // builder: (context) => UploadImage(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        ),
      );
    }
  }
}
