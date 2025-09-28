import 'package:firebase_complete/chat/component/chat_page.dart';
import 'package:firebase_complete/chat/component/user_tile.dart';
import 'package:firebase_complete/chat/controller/auth_controller.dart';
import 'package:firebase_complete/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

final con = Get.find()<ChatController>(ChatController());
final AuthCon = Get.find()<AuthController>(AuthController());

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: _buildUserList(),
    );
  }
}

Widget _buildUserList() {
  final con = Get.put<ChatController>(ChatController());
  return StreamBuilder(
    stream: con.getUserStream(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return const Center(child: Text("Error"));
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView(
        children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
      );
    },
  );
}

Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
  return UserTile(
    text: userData["email"],
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            receivedEmail: userData["email"],
            receiverID: userData["uid"],
          ),
        ),
      );
    },
  );
}
