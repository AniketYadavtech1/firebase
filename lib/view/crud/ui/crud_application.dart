import 'package:firebase_complete/view/crud/controller/crud_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CrudApplication extends StatefulWidget {
  const CrudApplication({super.key});

  @override
  State<CrudApplication> createState() => _CrudApplicationState();
}

class _CrudApplicationState extends State<CrudApplication> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final con = Get.find<CrudController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "",
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: con.studentName.value,
                  decoration: InputDecoration(labelText: "Enter Name"),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter Name' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: con.rollNumber.value,
                  decoration: InputDecoration(labelText: "Roll Number"),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter Your RolNumber'
                      : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: "StudentId"),
                  controller: con.studentID.value,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter Your RolNumber'
                      : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "student CGPA"),
                  controller: con.studentCGPA.value,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Enter Your RolNumber'
                      : null,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await con.createData();
                        Get.snackbar("Success", "Student data added");
                      } else {
                        Get.snackbar("failed", "failed to add Data");
                      }
                    },
                    child: Text("submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
