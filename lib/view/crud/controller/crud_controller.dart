import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/add_user.dart';
import '../service/crud_service.dart';

class CrudController extends GetxController {
  final service = crudService();

  final studentName = TextEditingController().obs;
  final studentID = TextEditingController().obs;
  final rollNumber = TextEditingController().obs;
  final studentCGPA = TextEditingController().obs;
  RxBool load = false.obs;
  RxList<StudentModel> student = <StudentModel>[].obs;

  Future<void> createData() async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('HomeData').doc();
    Map<String, dynamic> getStudent = ({
      "studentName": studentName.value,
      "studentID": studentID.value,
      "rollNumber": rollNumber.value,
      "studentCGPA": studentCGPA.value
    });
    load.value = false;
    documentReference.get().whenComplete(() => print('$getStudent'));

    print("get Data succfully ${getStudent}");
    load.value = true;
  }

  @override
  void onClose() {
    studentName.value.dispose();
    studentID.value.dispose();
    rollNumber.value.dispose();
    studentCGPA.value.dispose();
    super.onClose();
  }
}
