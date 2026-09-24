// import 'package:firebase_complete/talknest/auth/controller/auth_controller.dart';
// import 'package:firebase_complete/talknest/auth/ui/login_screen.dart';
// import 'package:firebase_complete/talknest/chat/component/chat_page.dart';
// import 'package:firebase_complete/talknest/chat/controller/chat_controller.dart';
// import 'package:firebase_complete/utils/app_color.dart';
// import 'package:firebase_complete/utils/app_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/get_instance.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// class HomeScreenViewChat extends StatelessWidget {
//   final ChatController controller = Get.put(ChatController());
//   final AuthController authController = Get.put(AuthController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         actions: [],
//         title: Obx(() => Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Welcome, ${authController.currentUserName.value}",
//                   style: AppText.black14600,
//                 ),
//                 TextButton(
//                     onPressed: () async {
//                       await authController.logout();
//                       await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()));
//                     },
//                     child: Icon(
//                       Icons.logout,
//                       color: AppColors.red,
//                       size: 20,
//                     ))
//               ],
//             )),
//       ),
//       body: StreamBuilder<List<Map<String, dynamic>>>(
//         stream: controller.getUserStream(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }
//           final users = snapshot.data!;
//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               if (user["uid"] == controller.currentUserId) return SizedBox();
//               return InkWell(
//                 onTap: () {
//                   Get.to(() => ChatPage(
//                         receiverID: user["uid"],
//                         receivedName: user["username"] ?? user["email"],
//                       ));
//                 },
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 4,
//                         spreadRadius: 1,
//                         color: Colors.black12,
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.blueAccent,
//                         radius: 22,
//                         child: Text(
//                           (user["username"] ?? user["email"])
//                               .toString()
//                               .substring(0, 1)
//                               .toUpperCase(),
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 15),
//                       Expanded(
//                         child: Text(
//                           user["username"] ?? user["email"],
//                           style: AppText.black14600,
//                         ),
//                       ),
//                       Icon(Icons.chat, color: Colors.grey),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:firebase_complete/talknest/auth/controller/auth_controller.dart';
import 'package:firebase_complete/talknest/auth/ui/login_screen.dart';
import 'package:firebase_complete/talknest/chat/component/chat_page.dart';
import 'package:firebase_complete/talknest/chat/controller/chat_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenViewChat extends StatelessWidget {
  HomeScreenViewChat({super.key});

  final ChatController controller = Get.put(ChatController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,

      // ------------------------------------------------------------
      // iOS STYLE BODY
      // ------------------------------------------------------------

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // --------------------------------------------------------
            // iOS STYLE HEADER
            // --------------------------------------------------------

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  15,
                  20,
                  10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Title
                    Expanded(
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Messages",
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w700,
                                color: CupertinoColors.label,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Welcome, ${authController.currentUserName.value}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                color: CupertinoColors.secondaryLabel,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Logout button
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        await authController.logout();

                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          CupertinoIcons.square_arrow_right,
                          size: 21,
                          color: CupertinoColors.systemRed,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --------------------------------------------------------
            // SEARCH STYLE HEADER
            // --------------------------------------------------------

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey5,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      SizedBox(width: 12),
                      Icon(
                        CupertinoIcons.search,
                        size: 18,
                        color: CupertinoColors.secondaryLabel,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --------------------------------------------------------
            // SECTION TITLE
            // --------------------------------------------------------

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  22,
                  20,
                  8,
                ),
                child: const Text(
                  "Chats",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: CupertinoColors.label,
                  ),
                ),
              ),
            ),

            // --------------------------------------------------------
            // USERS
            // --------------------------------------------------------

            StreamBuilder<List<Map<String, dynamic>>>(
              stream: controller.getUserStream(),
              builder: (context, snapshot) {
                // Loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius: 14,
                      ),
                    ),
                  );
                }

                // Error
                if (snapshot.hasError) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        "Something went wrong",
                        style: TextStyle(
                          fontSize: 15,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                    ),
                  );
                }

                final users = snapshot.data ?? [];

                // Remove current user
                final otherUsers = users.where((user) {
                  return user["uid"] != controller.currentUserId;
                }).toList();

                // Empty state
                if (otherUsers.isEmpty) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.bubble_left_bubble_right,
                            size: 48,
                            color: CupertinoColors.systemGrey,
                          ),
                          SizedBox(height: 12),
                          Text(
                            "No chats yet",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.label,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Start a conversation with someone",
                            style: TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.secondaryLabel,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // User List
                return SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    4,
                    16,
                    20,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final user = otherUsers[index];

                        final String name = (user["username"] ?? user["email"] ?? "User").toString();

                        final String firstLetter = name.isNotEmpty ? name[0].toUpperCase() : "U";

                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 2,
                          ),
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Get.to(
                                () => ChatPage(
                                  receiverID: user["uid"],
                                  receivedName: user["username"] ?? user["email"],
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 11,
                              ),
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemBackground,
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // ------------------------------------------------
                                  // AVATAR
                                  // ------------------------------------------------

                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: CupertinoColors.systemBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      firstLetter,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 13),

                                  // ------------------------------------------------
                                  // NAME + EMAIL
                                  // ------------------------------------------------

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: CupertinoColors.label,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          (user["email"] ?? "Tap to message").toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: CupertinoColors.secondaryLabel,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // ------------------------------------------------
                                  // CHEVRON
                                  // ------------------------------------------------

                                  const Icon(
                                    CupertinoIcons.chevron_right,
                                    size: 18,
                                    color: CupertinoColors.tertiaryLabel,
                                  ),

                                  const SizedBox(width: 4),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: otherUsers.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
