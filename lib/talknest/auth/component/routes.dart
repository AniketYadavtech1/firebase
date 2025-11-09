import 'package:firebase_complete/notification/home_screen.dart';
import 'package:firebase_complete/talknest/auth/component/splace.dart';
import 'package:firebase_complete/talknest/auth/ui/login_screen.dart';
import 'package:firebase_complete/talknest/auth/ui/signup_screen.dart';
import 'package:firebase_complete/talknest/profile/ui/profile_photo.dart';
import 'package:get/get.dart';

import '../../chat/ui/home.dart';

class AppPages {
  final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(name: Routes.initial, page: () => SplashScreen()),
    GetPage<dynamic>(name: Routes.signupInScreen, page: () => HomeScreenViewChat()),
    GetPage<dynamic>(name: Routes.signInScreen, page: () => HomeScreenViewChat()),
    GetPage<dynamic>(name: Routes.signInScreen, page: () => EditProfileView()),

  ];
}

abstract class Routes {
  static const String initial = '/';
  /// Auth
  static const signInScreen = '/signInScreen';
  static const verifyOtpScreen = '/verifyOtpScreen';
  static const signupInScreen = '/signupInScreen';
  static const profile = "/profile";
}
