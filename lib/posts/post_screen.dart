import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_complete/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'add_post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          size: 18,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Database',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPostScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),

            // Builder(builder: (context) {
            //   return StreamBuilder(
            //     stream: ref.onValue,
            //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            //       if (!snapshot.hasData ||
            //           snapshot.data!.snapshot.value == null) {
            //         return Center(child: CircularProgressIndicator());
            //       } else {
            //         Map<dynamic, dynamic> map =
            //             snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            //         List<dynamic> list = map.values.toList();
            //
            //         return Expanded(
            //           child: ListView.builder(
            //             itemCount: list.length,
            //             itemBuilder: (context, index) {
            //               final item = list[index];
            //
            //               if (item is! Map ||
            //                   item['title'] == null ||
            //                   item['id'] == null) {
            //                 return ListTile(
            //                   title: Text("Invalid data"),
            //                   subtitle: Text("Check your database structure"),
            //                 );
            //               }
            //
            //               return ListTile(
            //                 title: Text(item['title'].toString()),
            //                 subtitle: Text(item['id'].toString()),
            //               );
            //             },
            //           ),
            //         );
            //       }
            //     },
            //   );
            // }),
            // dynamic
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('title').value.toString();
                  if (searchFilter.text.isEmpty) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(title,
                                    snapshot.child('id').value.toString());
                              },
                              leading: Icon(Icons.edit),
                              title: Text("Edit"),
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                ref
                                    .child(
                                      snapshot.child('id').value.toString(),
                                    )
                                    .remove();
                              },
                              leading: Icon(Icons.delete),
                              title: Text("Delete"),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (title.toLowerCase().contains(
                        searchFilter.text.toLowerCase().toLowerCase(),
                      )) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
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
                ref.child(id).update(
                  {
                    'title': editController.text.toLowerCase(),
                  },
                ).then((value) {
                  // Utils().tostMessage("Post Update");
                }).onError((error, stackTrace) {
                  // Utils().tostMessage(error.toString());
                });
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
