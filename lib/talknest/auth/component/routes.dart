import 'package:firebase_complete/talknest/auth/component/splace.dart';
import 'package:firebase_complete/talknest/auth/ui/login_screen.dart';
import 'package:firebase_complete/talknest/auth/ui/signup_screen.dart';
import 'package:get/get.dart';

class AppPages {
  final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(name: Routes.initial, page: () => SplashScreen()),
    GetPage<dynamic>(name: Routes.signupInScreen, page: () => SignupScreen()),
    GetPage<dynamic>(name: Routes.signInScreen, page: () => LoginScreen()),
  ];
}

abstract class Routes {
  static const String initial = '/';
  /// Auth
  static const signInScreen = '/signInScreen';
  static const verifyOtpScreen = '/verifyOtpScreen';
  static const signupInScreen = '/signupInScreen';
}
