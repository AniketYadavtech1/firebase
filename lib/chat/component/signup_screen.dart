import 'package:firebase_complete/chat/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/roundbutton.dart';
import '../controller/auth_controller.dart';
import 'login_screen.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          size: 15,
        ),
        title: Text('SignUp'),
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
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: con.emailSinUp,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefix: Icon(Icons.alternate_email),
                    ),
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
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: con.passwordSinUp,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefix: Icon(Icons.alternate_email),
                    ),
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
            Roundbutton(
              title: 'SignUp',
              loading: con.load.value,
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  bool isSuccess = await con.signUp();
                  if (isSuccess) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenView()));
                  }
                }
              },
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
                        builder: (context) => LoginView(),
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
