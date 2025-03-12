import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/ui/auth/verify_code.dart';
import 'package:firebase_complete/utils/utils.dart';
import 'package:firebase_complete/widgets/roundbutton.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          size: 15,
        ),
        centerTitle: true,
        title: Text(
          "Login With Phone Number",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneNumberController,
              decoration: InputDecoration(hintText: "+11 234, 3455, 234"),
            ),
            SizedBox(
              height: 10,
            ),
            Roundbutton(
              title: "Login",
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });

                auth.verifyPhoneNumber(
                  phoneNumber: phoneNumberController.text,
                  verificationCompleted: (_) {
                    setState(() {
                      loading = false;
                    });
                  },
                  verificationFailed: (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().tostMessage(e.toString());
                  },
                  codeSent: (String verificationId, int? token) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerifyCode(
                                  verificationId: verificationId,
                                )));
                    setState(() {
                      loading = false;
                    });
                  },
                  codeAutoRetrievalTimeout: (e) {
                    Utils().tostMessage(e.toString());
                    setState(() {
                      loading = false;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
