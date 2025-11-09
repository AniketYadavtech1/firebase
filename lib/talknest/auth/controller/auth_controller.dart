import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/utils/app_color.dart';
import 'package:firebase_complete/utils/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  RxBool loading = false.obs;
  RxBool loadSign = false.obs;
  RxBool load = false.obs;
  RxBool loadUser = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailSinUp = TextEditingController();
  final passwordSinUp = TextEditingController();
  final nameController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String verificationId = "";

  late final userId = _auth.currentUser?.uid ?? "";


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailSinUp.dispose();
    passwordSinUp.dispose();
    nameController.dispose();
    super.onClose();
  }

  Future<bool> login() async {
    try {
      loading.value = true;
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      loading.value = false;
      return true;
    } catch (error) {
      loading.value = false;
      return false;
    }
  }

  Future<bool> signUp(String username, String email, String password) async {
    try {
      loadSign.value = true;

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      await _firestore.collection("Users").doc(uid).set({
        "uid": uid,
        "username": username,
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
      });
      loadSign.value = false;
      Get.snackbar(
        "Success",
        "Account created successfully!",
        backgroundColor: AppColors.green,
        colorText: AppColors.green,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      loadSign.value = false;
      Get.snackbar(
        "Sign Up Failed",
        e.message ?? "Something went wrong",
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
        duration: Duration(seconds: 3),
      );
      return false;
    } catch (e) {
      loadSign.value = false;
      Get.snackbar(
        "Error${e}",
        "Something went wrong",
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
      return false;
    }
  }

  RxString currentUserName = "".obs;

  Future<void> fetchCurrentUserName() async {
    try {
      if (_auth.currentUser != null) {
        final uid = _auth.currentUser!.uid;
        DocumentSnapshot userDoc =
            await _firestore.collection("Users").doc(uid).get();
        if (userDoc.exists && userDoc.data() != null) {
          var data = userDoc.data() as Map<String, dynamic>;
          currentUserName.value = data["username"] ?? "";
        }
      }
    } catch (e) {
      print("Error fetching user name: $e");
    }
  }

  Future<void> logout() async {
    try {
      loadUser.value = true;
      await _auth.signOut();
      emailController.clear();
      passwordController.clear();
      emailSinUp.clear();
      passwordSinUp.clear();
      loadUser.value = false;
      nameController.clear();
    } catch (e) {
      loadUser.value = false;
    }
  }
  @override
  void onInit() {
    fetchCurrentUserName();
    super.onInit();
  }

}
