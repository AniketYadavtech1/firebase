import 'package:firebase_complete/utils/utils.dart';
import 'package:firebase_complete/widgets/roundbutton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

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
          "Add Post",
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
                setState(() {
                  loading = true;
                });
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                databaseRef.child(id).set({
                  'title': postController.text.toString(),
                  'id': DateTime.now().millisecondsSinceEpoch.toString(),
                }).then((value) {
                  Utils().tostMessage('Post added');
                  setState(() {
                    loading = false;
                  });
                }).onError(
                  (error, stackTrace) {
                    Utils().tostMessage(error.toString());
                    setState(
                      () {
                        loading = false;
                      },
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
