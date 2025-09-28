import 'package:firebase_complete/chat/component/signup_screen.dart';
import 'package:firebase_complete/chat/ui/home.dart';
import 'package:firebase_complete/ui/auth/login_with_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/roundbutton.dart';
import '../controller/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          size: 15,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Login Page'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Padding(
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
                      controller: con.emailController,
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
                      // obscureText: true,
                      controller: con.passwordController,
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
                title: 'Login',
                loading: con.loading.value,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    bool isSuccess = await con.login();
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
                  Text("Don't have an account "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupView(),
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
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPhone()));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Center(child: Text('Login with Phone Number')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
