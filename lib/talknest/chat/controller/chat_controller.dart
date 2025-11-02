import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get currentUserId => _auth.currentUser!.uid;
  String get currentUserEmail => _auth.currentUser!.email ?? "";

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firebase.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
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
    final messageData = {
      "senderId": currentUserId,
      "senderEmail": currentUserEmail,
      "receiverId": receiverID,
      "message": message,
      "timestamp": FieldValue.serverTimestamp(),
    };
    await _firebase.collection("chatRooms").doc(chatRoomId).collection("messages").add(messageData);
  }

  Stream<QuerySnapshot> getMessages(String receiverID) {
    final String chatRoomId = getChatRoomId(currentUserId, receiverID);
    return _firebase
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}
