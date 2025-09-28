import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/chat/component/login_screen.dart';
import 'package:firebase_complete/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool loading = false.obs;
  RxBool load = false.obs;
  RxBool loadUser = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final emailSinUp = TextEditingController();
  final passwordSinUp = TextEditingController();

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
      Utils().tostMessage(error.toString());
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      load.value = true;
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailSinUp.text.trim(),
        password: passwordSinUp.text.trim(),
      );
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": emailSinUp.text.trim(),
      });

      load.value = false;
      return true;
    } catch (error) {
      load.value = false;
      Utils().tostMessage(error.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offAll(() => LoginView());
    } catch (error) {
      Utils().tostMessage("Signout failed: $error");
    }
  }
}
