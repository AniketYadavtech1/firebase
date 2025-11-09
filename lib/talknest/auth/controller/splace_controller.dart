import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/talknest/auth/ui/login_screen.dart' show LoginScreen;
import 'package:firebase_complete/talknest/chat/ui/home.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    checkUserLogin();
  }

  void checkUserLogin() async {
    await Future.delayed(Duration(seconds: 2)); // Splash delay

    if (_auth.currentUser != null) {
      // ✅ User is logged in
      Get.offAll(() => HomeScreenView());
    } else {
      // ❌ Not logged in
      Get.offAll(() => LoginScreen());
    }
  }
}
