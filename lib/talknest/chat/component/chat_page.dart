import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_complete/talknest/chat/controller/chat_controller.dart';
import 'package:firebase_complete/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  final String receivedName;
  final String receiverID;

  const ChatPage({
    super.key,
    required this.receivedName,
    required this.receiverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController controller = Get.find();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _showEmojiPicker = false;

  void sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    controller.sendMessage(widget.receiverID, _messageController.text.trim());
    _messageController.clear();
  }

  void toggleEmoji() {
    FocusScope.of(context).unfocus(); // hide keyboard
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          widget.receivedName,
          style: AppText.black14600,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: controller.getMessages(widget.receiverID),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg =
                          messages[index].data() as Map<String, dynamic>?;

                      final bool isMe =
                          msg?["senderId"] == controller.currentUserId;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child:
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? const Color(0xFFDCF8C6)
                                  : const Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                                bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 3,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  msg?["message"] ?? "",
                                  style: TextStyle(
                                    color: isMe ? Colors.black : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    msg?["timestamp"]
                                            ?.toDate()
                                            .toString()
                                            .substring(11, 16) ??
                                        "",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isMe
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Card(
                  elevation: 0.5,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.emoji_emotions_outlined),
                        onPressed: toggleEmoji,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          focusNode: _focusNode,
                          onTap: () => setState(() => _showEmojiPicker = false),
                          decoration: const InputDecoration(
                            hintText: "Type a message",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: sendMessage,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_showEmojiPicker)
              SizedBox(
                height: 300,
                child: EmojiPicker(
                  textEditingController: _messageController,
                  config: Config(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
