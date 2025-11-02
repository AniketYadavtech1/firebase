import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_complete/utils/utils.dart';
import 'package:firebase_complete/utils/roundbutton.dart';
import 'package:flutter/material.dart';

class AddFireStoreScreen extends StatefulWidget {
  const AddFireStoreScreen({super.key});

  @override
  State<AddFireStoreScreen> createState() => _AddFireStoreScreenState();
}

class _AddFireStoreScreenState extends State<AddFireStoreScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: Text(
          "Add Firebase Store Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'What is your mind',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Roundbutton(
              title: 'Add',
              loading: loading,
              onTap: () {
                if (postController.text.trim().isEmpty) {
                  // Utils().tostMessage("Please enter some text");
                  return;
                }
                setState(() {
                  loading = true;
                });
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                print('ID: $id');
                print('Text to add:${postController.text}');
                fireStore.doc(id).set({
                  'title': postController.text.trim(),
                  'id': id,
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  // Utils().tostMessage('Post added');
                  print('Post added successfully');
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                  });
                  print('Error : $error');
                  // Utils().tostMessage(error.toString());
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
