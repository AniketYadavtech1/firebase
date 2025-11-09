import 'package:firebase_complete/notification/home_screen.dart';
import 'package:firebase_complete/talknest/chat/ui/home.dart';

import 'package:firebase_complete/utils/app_color.dart';
import 'package:firebase_complete/utils/app_text.dart';
import 'package:firebase_complete/utils/common_button.dart';
import 'package:firebase_complete/utils/commont_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
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
                load: con.loadSign.value,
                label: "SignUp",
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  bool isSuccess = await con.signUp(
                    con.nameController.text.trim(),
                    con.emailSinUp.text.trim(),
                    con.passwordSinUp.text.trim(),
                  );

                  if (isSuccess) {
                    Get.snackbar(
                      "Success",
                      "SingUp Successfully",
                      backgroundColor: AppColors.gradientOne,
                      colorText: Colors.white,
                      duration: Duration(seconds: 4),
                    );
                    await con.fetchCurrentUserName();
                    Get.off(() => HomeScreenViewChat());
                  } else {
                    Get.snackbar(
                      "Error",
                      "SignUp failed",
                      backgroundColor: AppColors.red,
                      colorText: Colors.white,
                      duration: Duration(seconds: 4),
                    );
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
