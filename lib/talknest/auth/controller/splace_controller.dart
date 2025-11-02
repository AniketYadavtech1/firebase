import 'package:firebase_complete/talknest/auth/component/routes.dart';
import 'package:firebase_complete/utils/local_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  checkLogin() async {
    final userId = await LocalStorage.getUserId();
    Future.delayed(
      const Duration(seconds: 3),
      () => (userId != "" && userId != "0")
          ? Get.offAllNamed(Routes.signInScreen)
          : Get.offAllNamed(Routes.signInScreen),
    );
  }

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }
}
