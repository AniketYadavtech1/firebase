import 'package:firebase_complete/talknest/auth/ui/signup_screen.dart' show SignupScreen;
import 'package:firebase_complete/talknest/chat/ui/home.dart';
import 'package:firebase_complete/utils/app_color.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
// iOS-style top icon
                  Center(
                    child: Container(
                      height: 72,
                      width: 72,
                      decoration: BoxDecoration(
                        color: AppColors.gradientThree,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(
                        Icons.chat_bubble_rounded,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

// Heading
                  Center(
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Center(
                    child: Text(
                      "Sign in to continue to TalkNest",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  const SizedBox(height: 38),

// Login form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
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
                        const SizedBox(height: 18),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
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

                  const SizedBox(height: 28),

// Login button
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: CommonButton(
                        buttonColor: AppColors.gradientThree,
                        buttonBorderColor: AppColors.gradientThree,
                        labelColor: AppColors.white,
                        label: "Login",
                        load: con.loading.value,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool isSuccess = await con.login();

                            if (isSuccess) {
                              await con.fetchCurrentUserName();

                              Get.snackbar(
                                "Success",
                                "Login Successfully",
                                backgroundColor: AppColors.gradientOne,
                                colorText: AppColors.white,
                                duration: const Duration(seconds: 4),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreenViewChat(),
                                ),
                              );
                            } else {
                              Get.snackbar(
                                "Error",
                                "Login Failed",
                                backgroundColor: AppColors.red,
                                colorText: Colors.white,
                                duration: const Duration(seconds: 4),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

// Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

// Signup
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 5),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.gradientThree,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
