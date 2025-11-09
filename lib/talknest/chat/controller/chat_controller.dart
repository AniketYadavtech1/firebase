//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
//
// class ChatController extends GetxController {
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   String get currentUserId => _auth.currentUser!.uid;
//   String get currentUserEmail => _auth.currentUser!.email ?? "";
//
//
//   Stream<List<Map<String, dynamic>>> getUserStream() {
//     return _firestore.collection("Users").snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         final data = doc.data();
//
//         return {
//           "uid": data["uid"],
//           "email": data["email"],
//           "username": data["username"],
//         };
//       }).toList();
//     });
//   }
//
//
//   String getChatRoomId(String user1, String user2) {
//     List<String> users = [user1, user2];
//     users.sort();
//     return users.join("_");
//   }
//
//
//   Future<void> sendMessage(String receiverID, String message) async {
//     if (message.trim().isEmpty) return;
//     final String chatRoomId = getChatRoomId(currentUserId, receiverID);
//     await _firestore
//         .collection("chatRooms")
//         .doc(chatRoomId)
//         .collection("messages")
//         .add({
//       "senderId": currentUserId,
//       "senderEmail": currentUserEmail,
//       "receiverId": receiverID,
//       "message": message,
//       "timestamp": FieldValue.serverTimestamp(),
//     });
//   }
//
//   Stream<QuerySnapshot> getMessages(String receiverID) {
//     final String chatRoomId = getChatRoomId(currentUserId, receiverID);
//
//     return _firestore
//         .collection("chatRooms")
//         .doc(chatRoomId)
//         .collection("messages")
//         .orderBy("timestamp", descending: true)
//         .snapshots();
//   }
// }

// chat
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get currentUserId => _auth.currentUser!.uid;
  String get currentUserEmail => _auth.currentUser!.email ?? "";

  Future<void> saveToken(String token) async {
    await _firestore.collection("Users").doc(currentUserId).update({
      "fcmToken": token,
    });
  }

  Future<void> sendPushNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    const String serverKey =
        "BDka5IJOu0kqPcavnFmbOpfJRVAHfx7huoWzXUQeveJDbx_ML5Ym1-dnvmvKKv7-j9B8loH9Els2cMjlJM9Vy7c";

    final Uri url = Uri.parse("https://fcm.googleapis.com/fcm/send");

    final message = {
      "to": token,
      "notification": {
        "title": title,
        "body": body,
      },
      "priority": "high",
    };

    await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=$serverKey",
      },
      body: jsonEncode(message),
    );
  }

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          "uid": data["uid"],
          "email": data["email"],
          "username": data["username"],
          "fcmToken": data["fcmToken"],
        };
      }).toList();
    });
  }

  String getChatRoomId(String user1, String user2) {
    List<String> users = [user1, user2];
    users.sort();
    return users.join("_");
  }

  Future<void> sendMessage(String receiverID, String message) async {
    if (message.trim().isEmpty) return;

    final String chatRoomId = getChatRoomId(currentUserId, receiverID);

    await _firestore
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .add({
      "senderId": currentUserId,
      "senderEmail": currentUserEmail,
      "receiverId": receiverID,
      "message": message,
      "timestamp": FieldValue.serverTimestamp(),
    });

    DocumentSnapshot userDoc =
        await _firestore.collection("Users").doc(receiverID).get();

    String? token = userDoc["fcmToken"];

    if (token != null && token.isNotEmpty) {
      sendPushNotification(
        token: token,
        title: currentUserEmail,
        body: message,
      );
    }
  }

  Stream<QuerySnapshot> getMessages(String receiverID) {
    final String chatRoomId = getChatRoomId(currentUserId, receiverID);

    return _firestore
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}
