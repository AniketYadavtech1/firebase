import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Roundbutton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final bool loading;

  const Roundbutton({
    super.key,
    this.title,
    this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Center(
            child: loading
                ? CircularProgressIndicator()
                : Text(
                    title!,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}
