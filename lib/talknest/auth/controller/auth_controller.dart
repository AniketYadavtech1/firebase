import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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

  Future<bool> logins() async {
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

  Future<bool> login() async {
    try {
      loading.value = true;

      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        Get.snackbar(
          "Error",
          "Please enter email and password",
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
        return false;
      }

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.snackbar(
        "Success",
        "Login successful",
        backgroundColor: AppColors.green,
        colorText: AppColors.white,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      print("Firebase Login Error");
      print("Code: ${e.code}");
      print("Message: ${e.message}");

      String message;

      switch (e.code) {
        case 'invalid-credential':
          message = "Invalid email or password.";
          break;

        case 'user-not-found':
          message = "No account found with this email.";
          break;

        case 'wrong-password':
          message = "Incorrect password.";
          break;

        case 'invalid-email':
          message = "Invalid email address.";
          break;

        case 'network-request-failed':
          message = "Network error. Check emulator internet connection.";
          break;

        case 'too-many-requests':
          message = "Too many attempts. Try again later.";
          break;

        case 'user-disabled':
          message = "This account has been disabled.";
          break;

        default:
          message = e.message ?? "Login failed.";
      }

      Get.snackbar(
        "Login Failed",
        message,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );

      return false;
    } catch (e) {
      print("Login Error: $e");

      Get.snackbar(
        "Error",
        "Something went wrong.",
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );

      return false;
    } finally {
      loading.value = false;
    }
  }

  Future<bool> signUps(String username, String email, String password) async {
    try {
      loadSign.value = true;
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
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

  Future<bool> signUp(
    String username,
    String email,
    String password,
  ) async {
    try {
      loadSign.value = true;

      username = username.trim();
      email = email.trim();
      password = password.trim();

      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        Get.snackbar(
          "Error",
          "Please fill all fields",
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
        return false;
      }

      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user == null) {
        return false;
      }

      final uid = user.uid;

      await _firestore.collection("Users").doc(uid).set({
        "uid": uid,
        "username": username,
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
      });

      Get.snackbar(
        "Success",
        "Account created successfully!",
        backgroundColor: AppColors.green,
        colorText: AppColors.white,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      print("Firebase Signup Error");
      print("Code: ${e.code}");
      print("Message: ${e.message}");

      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = "This email is already registered.";
          break;

        case 'weak-password':
          message = "Password is too weak.";
          break;

        case 'invalid-email':
          message = "Invalid email address.";
          break;

        case 'network-request-failed':
          message = "Network error. Check emulator internet.";
          break;

        case 'operation-not-allowed':
          message = "Email/password login is disabled in Firebase.";
          break;

        case 'too-many-requests':
          message = "Too many attempts. Try again later.";
          break;

        default:
          message = e.message ?? "Signup failed.";
      }

      Get.snackbar(
        "Sign Up Failed",
        message,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
        duration: const Duration(seconds: 3),
      );

      return false;
    } catch (e) {
      print("Signup Error: $e");

      Get.snackbar(
        "Error",
        "Something went wrong.",
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );

      return false;
    } finally {
      loadSign.value = false;
    }
  }

  RxString currentUserName = "".obs;

  Future<void> fetchCurrentUserName() async {
    try {
      if (_auth.currentUser != null) {
        final uid = _auth.currentUser!.uid;
        DocumentSnapshot userDoc = await _firestore.collection("Users").doc(uid).get();
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
