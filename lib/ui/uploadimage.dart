import 'dart:io';
import 'package:firebase_complete/widgets/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  final picker = ImagePicker();
  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {});

    if (pickedFile != null) {
    } else {
      print('No image picked');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          size: 17,
          color: Colors.white,
        ),
        title: Text(
          "Upload Image",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: _image != null
                      ? Image.file(_image!.absolute)
                      : Center(
                          child: Icon(Icons.image),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Roundbutton(
              title: "Upload",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
