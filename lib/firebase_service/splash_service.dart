import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../ui/uploadimage.dart';

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
            // builder: (context) => FireStoreScreen(),
            builder: (context) => UploadImage(),
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
