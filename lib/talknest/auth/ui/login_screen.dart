import 'package:firebase_complete/talknest/auth/ui/signup_screen.dart'
    show SignupScreen;
import 'package:firebase_complete/talknest/chat/ui/home.dart';
import 'package:firebase_complete/talknest/profile/ui/profile_photo.dart';
import 'package:firebase_complete/utils/app_color.dart';
import 'package:firebase_complete/utils/app_text.dart';
import 'package:firebase_complete/utils/common_button.dart';
import 'package:firebase_complete/utils/commont_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final con = Get.put<AuthController>(AuthController());
  final _formKey = GlobalKey<FormState>();

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
        automaticallyImplyLeading: false,
        title: Text(
          'Login Page',
          style: AppText.black14600,
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CommonTextField(
                      labelText: "Email",
                      con: con.emailController,
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
                      con: con.passwordController,
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
                  label: "login",
                  load: con.loading.value,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool isSuccess = await con.login();

                      if (isSuccess) {
                        Get.snackbar(
                          "Success",
                          "Login Successfully",
                          backgroundColor: AppColors.gradientOne,
                          colorText: Colors.white,
                          duration: Duration(seconds: 4),
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreenView()));
                      }else{
                        Get.snackbar(
                          "Error",
                          "Login Successfully",
                          backgroundColor: AppColors.red,
                          colorText: Colors.white,
                          duration: Duration(seconds: 4),
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
                  Text("Don't have an account "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ),
                      );
                    },
                    child: Text("SinUp"),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
