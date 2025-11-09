import 'package:firebase_complete/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/chat_controller.dart';
import '../component/chat_page.dart';

class HomeScreenView extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Users",
        style: AppText.black14600,
      )),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: controller.getUserStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              // Skip current logged-in user
              if (user["uid"] == controller.currentUserId) return SizedBox();

              return ListTile(
                title: Text(
                  user["username"] ?? user["email"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Get.to(() => ChatPage(
                    receiverID: user["uid"],
                    receivedName: user["username"] ?? user["email"],
                  ));
                },
              );
            },
          );

        },
      ),
    );
  }
}
