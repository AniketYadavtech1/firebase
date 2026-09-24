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
    await Future.delayed(Duration(seconds: 2));

    if (_auth.currentUser != null) {
      Get.offAll(() => HomeScreenViewChat());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
