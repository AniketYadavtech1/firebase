import 'package:firebase_complete/notification/home_screen.dart';
import 'package:firebase_complete/talknest/profile/ui/profile_photo.dart';
import 'package:firebase_complete/utils/app_color.dart';
import 'package:firebase_complete/utils/app_text.dart';
import 'package:firebase_complete/utils/common_button.dart';
import 'package:firebase_complete/utils/commont_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/roundbutton.dart';
import '../controller/auth_controller.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  final con = Get.put<AuthController>(AuthController());

  @override
  void dispose() {
    con.emailController.dispose();
    con.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: Icon(
          Icons.arrow_back_ios,
          size: 15,
        ),
        title: Text(
          'SignUp',
          style: AppText.black14600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CommonTextField(
                    labelText: "Name",
                    con: con.nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Name ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    labelText: "Email",
                    con: con.emailSinUp,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter email id";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    labelText: "Password",
                    con: con.passwordSinUp,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter password";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => CommonButton(
                buttonColor: AppColors.gradientThree,
                buttonBorderColor: AppColors.gradientThree,
                labelColor: AppColors.white,
                label: con.loading.value ? "Please wait" : "Sign Up",
                load: con.loading.value,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool success = await con.signUp(
                      username: con.nameController.text.trim(),
                      email: con.emailSinUp.text.trim(),
                      password: con.passwordSinUp.text.trim(),
                    );
                    if (success) {
                      Get.snackbar(
                        "Success",
                        "Signup Successfully",
                        backgroundColor: AppColors.gradientOne,
                        colorText: Colors.white,
                      );

                      Get.off(HomeScreen());
                    } else {
                      Get.snackbar(
                        "Failed",
                        "Something went wrong",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Already have an account "),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text("Login"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
