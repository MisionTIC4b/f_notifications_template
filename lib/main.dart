import 'package:f_notifications/ui/app.dart';
import 'package:f_notifications/ui/controllers/notifications_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  final controller = Get.put(NotificationsController());
  await Firebase.initializeApp();
  await controller.initialize(
      androidFavicon: '@drawable/app_isotype', color: Colors.blue);
  runApp(const NotificationsApp());
}
