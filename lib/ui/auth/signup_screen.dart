import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/roundbutton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void SignUp() {

    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      Utils().tostMessage(error.toString());
      setState(() {
        loading = false;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    controller: emailController,
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
                    obscureText: true,
                    controller: passwordController,
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
              loading: loading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  SignUp();
                  // setState(() {
                  //   loading = true;
                  // });
                  // _auth
                  //     .createUserWithEmailAndPassword(
                  //         email: emailController.text.toString(),
                  //         password: passwordController.text.toString())
                  //     .then((value) {
                  //   setState(() {
                  //     loading = false;
                  //   });
                  // }).onError((error, stackTrace) {
                  //   Utils().tostMessage(error.toString());
                  //   setState(() {
                  //     loading = false;
                  //   });
                  // });
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
