import 'package:firebase_complete/talknest/auth/controller/auth_controller.dart';
import 'package:firebase_complete/talknest/auth/ui/login_screen.dart';
import 'package:firebase_complete/talknest/chat/component/chat_page.dart';
import 'package:firebase_complete/talknest/chat/controller/chat_controller.dart';
import 'package:firebase_complete/utils/app_color.dart';
import 'package:firebase_complete/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomeScreenViewChat extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [],
        title: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome, ${authController.currentUserName.value}",
                  style: AppText.black14600,
                ),
                TextButton(
                    onPressed: () async {
                      await authController.logout();
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Icon(
                      Icons.logout,
                      color: AppColors.red,
                      size: 20,
                    ))
              ],
            )),
      ),
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
              if (user["uid"] == controller.currentUserId) return SizedBox();
              return InkWell(
                onTap: () {
                  Get.to(() => ChatPage(
                        receiverID: user["uid"],
                        receivedName: user["username"] ?? user["email"],
                      ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 1,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 22,
                        child: Text(
                          (user["username"] ?? user["email"])
                              .toString()
                              .substring(0, 1)
                              .toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          user["username"] ?? user["email"],
                          style: AppText.black14600,
                        ),
                      ),
                      Icon(Icons.chat, color: Colors.grey),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
