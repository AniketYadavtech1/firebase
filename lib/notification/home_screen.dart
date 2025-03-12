import 'package:flutter/material.dart';

import 'notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.firebaseInit();
    notificationService.requestNotificationPermission();
    notificationService.isTokenRefresh();
    notificationService.getDeviceToken().then((value) {
      print("device token");
      print("Hi Aniket your data is print please do here");
      print(value);
      notificationService.FeatchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to notification"),
      ),
    );
  }
}
