import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'firestore_list_data.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});
  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();

  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  // final ref1 = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 18,
        ),
        title: Text(
          "Firebase Stote",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: fireStore,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        // ref
                        //     .doc(snapshot.data!.docs[index]['id'].toString())
                        //     .update({
                        //   'title': 'i am not good in flutter',
                        // }).then((value) {
                        //   Utils().tostMessage('update');
                        // }).onError((error, stackTrace) {
                        //   Utils().tostMessage(error.toString());
                        // });
                        //

                        ref
                            .doc(snapshot.data!.docs[index]['id'].toString())
                            .delete();
                      },
                      title:
                          Text(snapshot.data!.docs[index]['title'].toString()),
                      subtitle:
                          Text(snapshot.data!.docs[index]['id'].toString()),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFireStoreScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(
                hintText: "Edit",
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
