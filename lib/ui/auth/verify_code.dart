import 'package:flutter/material.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          size: 15,
        ),
        title: Text('Verify_Code'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
