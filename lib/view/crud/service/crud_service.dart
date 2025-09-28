import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/add_user.dart';

class crudService {
  RxList<StudentModel> student = <StudentModel>[].obs;

  Future<StudentModel?> createData(String? studentName, String? studentId,
      String? rollNumber, String? studentCGA) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('HomeData').doc();
    try {
      Map<String, dynamic> students = ({
        "studentName": studentName,
        "studentID": studentId,
        "rollNumber": rollNumber,
        "studentCGPA": studentCGA
      });
      documentReference
          .set(students)
          .whenComplete(() => print('$students created'));
    } catch (e) {
      Get.snackbar("success", "get Student Details  Succfyly");
    }
    return null;
  }
}
