import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_complete/talknest/chat/controller/chat_controller.dart';
import 'package:flutter/cupertino.dart';
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
  late final ChatController controller;

  final TextEditingController _messageController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  bool _showEmojiPicker = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ChatController>();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _showEmojiPicker) {
        setState(() {
          _showEmojiPicker = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void sendMessage() {
    final message = _messageController.text.trim();

    if (message.isEmpty) {
      return;
    }

    controller.sendMessage(
      widget.receiverID,
      message,
    );

    _messageController.clear();
  }

  void toggleEmoji() {
    if (_showEmojiPicker) {
      _focusNode.requestFocus();
      setState(() {
        _showEmojiPicker = false;
      });
    } else {
      _focusNode.unfocus();
      setState(() {
        _showEmojiPicker = true;
      });
    }
  }

  void openKeyboard() {
    if (_showEmojiPicker) {
      setState(() {
        _showEmojiPicker = false;
      });
    }

    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        if (mounted) {
          _focusNode.requestFocus();
        }
      },
    );
  }

  String formatTime(dynamic timestamp) {
    if (timestamp == null) {
      return "";
    }
    try {
      final DateTime date = timestamp.toDate();
      final int hour = date.hour > 12
          ? date.hour - 12
          : date.hour == 0
              ? 12
              : date.hour;
      final String minute = date.minute.toString().padLeft(2, '0');
      final String period = date.hour >= 12 ? "PM" : "AM";
      return "$hour:$minute $period";
    } catch (e) {
      return "";
    }
  }

  Widget messageBubble({
    required String message,
    required String time,
    required bool isMe,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          left: isMe ? 55 : 8,
          right: isMe ? 8 : 55,
          bottom: 3,
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFF007AFF) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(
                    isMe ? 20 : 5,
                  ),
                  bottomRight: Radius.circular(
                    isMe ? 5 : 20,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black87,
                  fontSize: 16,
                  height: 1.25,
                ),
              ),
            ),
            if (time.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  top: 3,
                  left: isMe ? 0 : 8,
                  right: isMe ? 8 : 0,
                ),
                child: Text(
                  time,
                  style: const TextStyle(
                    color: Colors.black38,
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget emptyChat() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: const BoxDecoration(
              color: Color(0xFFE5E5EA),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.chat_bubble_2_fill,
              size: 36,
              color: Color(0xFF8E8E93),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "No messages yet",
            style: TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "Start a conversation",
            style: TextStyle(
              color: Color(0xFFAEAEB2),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget chatAppBar() {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: const Color(0xFFF5F5F7),
      surfaceTintColor: Colors.transparent,
      leadingWidth: 50,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          CupertinoIcons.chevron_back,
          color: Color(0xFF007AFF),
          size: 28,
        ),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF007AFF),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.receivedName.isNotEmpty ? widget.receivedName[0].toUpperCase() : "?",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.receivedName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 1),
              const Row(
                children: [
                  Icon(
                    CupertinoIcons.circle_fill,
                    size: 7,
                    color: Color(0xFF34C759),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Online",
                    style: TextStyle(
                      color: Color(0xFF34C759),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.videocam,
            color: Color(0xFF007AFF),
            size: 25,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.phone,
            color: Color(0xFF007AFF),
            size: 22,
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget messageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        10,
        7,
        10,
        7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F7),
        border: Border(
          top: BorderSide(
            color: Colors.black.withOpacity(0.06),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: toggleEmoji,
            child: Container(
              width: 39,
              height: 39,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _showEmojiPicker ? CupertinoIcons.keyboard : CupertinoIcons.smiley,
                color: const Color(0xFF007AFF),
                size: 23,
              ),
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 39,
                maxHeight: 110,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(21),
                border: Border.all(
                  color: Colors.black.withOpacity(0.08),
                ),
              ),
              child: TextField(
                controller: _messageController,
                focusNode: _focusNode,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                onTap: openKeyboard,
                onSubmitted: (_) {
                  sendMessage();
                },
                decoration: const InputDecoration(
                  hintText: "Message",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 9,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 7),
          GestureDetector(
            onTap: sendMessage,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF007AFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.arrow_up,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emojiPicker() {
    return SizedBox(
      height: 300,
      child: EmojiPicker(
        textEditingController: _messageController,
        config: Config(
          height: 300,
          checkPlatformCompatibility: true,
          emojiViewConfig: const EmojiViewConfig(
            columns: 8,
            emojiSizeMax: 28,
            backgroundColor: Color(0xFFF5F5F7),
          ),
          categoryViewConfig: const CategoryViewConfig(
            backgroundColor: Color(0xFFF5F5F7),
          ),
          bottomActionBarConfig: const BottomActionBarConfig(
            backgroundColor: Color(0xFFF5F5F7),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: chatAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: controller.getMessages(
                  widget.receiverID,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        radius: 14,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Unable to load messages",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }

                  final messages = snapshot.data!.docs;

                  if (messages.isEmpty) {
                    return emptyChat();
                  }

                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 10,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index].data() as Map<String, dynamic>?;

                      final bool isMe = msg?["senderId"] == controller.currentUserId;

                      final String message = msg?["message"] ?? "";

                      final String time = formatTime(msg?["timestamp"]);

                      return messageBubble(
                        message: message,
                        time: time,
                        isMe: isMe,
                      );
                    },
                  );
                },
              ),
            ),
            messageInput(),
            if (_showEmojiPicker) emojiPicker(),
          ],
        ),
      ),
    );
  }
}
