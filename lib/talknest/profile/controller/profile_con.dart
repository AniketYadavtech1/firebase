import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../../auth/controller/auth_controller.dart';

class ProfileController extends GetxController {





  final auth = Get.find<AuthController>();
  Rxn<File> image = Rxn<File>();
  RxBool upload = false.obs;
  RxString profileUrl = "".obs;
  final nameCon = TextEditingController();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  Future<void> updateProfile() async {
    try {
      upload.value = true;

      final uid = auth.userId;
      String? downloadUrl;

      if (image.value != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child("profile_images")
            .child("$uid.jpg");

        await ref.putFile(image.value!);
        downloadUrl = await ref.getDownloadURL();
      }
      await FirebaseFirestore.instance.collection("Users").doc(uid).set({
        "name": nameCon.text.trim(),
        "profileImage": downloadUrl ?? profileUrl.value,
      }, SetOptions(merge: true));

      profileUrl.value = downloadUrl ?? profileUrl.value;

      Get.snackbar("Success", "Profile Updated");
      image.value = null;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      upload.value = false;
    }
  }

  Future<void> getProfileData() async {
    final uid = auth.userId;
    final doc =
        await FirebaseFirestore.instance.collection("Users").doc(uid).get();
    if (doc.exists) {
      nameCon.text = doc["name"] ?? "";
      profileUrl.value = doc["profileImage"] ?? "";
    }
  }
}
