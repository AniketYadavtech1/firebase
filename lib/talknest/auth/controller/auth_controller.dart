import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/utils/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  RxBool loading = false.obs;
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

  Future<bool> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    loading.value = true;

    try {
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

      loading.value = false;
      return true;

    } catch (e) {
      print("SignUp Error: $e");
      loading.value = false;
      return false;
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
}
