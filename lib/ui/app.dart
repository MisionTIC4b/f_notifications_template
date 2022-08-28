import 'package:f_notifications/ui/pages/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsApp extends StatelessWidget {
  const NotificationsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Notifications',
      home: MainPage(),
    );
  }
}
