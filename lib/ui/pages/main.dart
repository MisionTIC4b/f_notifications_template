import 'dart:io';

import 'package:f_notifications/ui/controllers/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _State();
}

class _State extends State<MainPage> {
  late final NotificationsController controller;
  late final TextEditingController notificationController;
  late bool subscribed;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    notificationController = TextEditingController();
    subscribed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: notificationController,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                            label: Text('Texto de notificacion:')),
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    ElevatedButton(
                      onPressed: notificationController.text.isEmpty
                          ? null
                          : () => controller.showLocalNotification(
                              title: 'Flutter Notification',
                              content: notificationController.text),
                      child: const Text('Mostrar'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: subscribed || Platform.isIOS
                        ? null
                        : () async {
                            await controller.subscribeTopic();
                            setState(() {
                              subscribed = true;
                            });
                          },
                    child: const Text('Subscribe Topic'),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  ElevatedButton(
                    onPressed: !subscribed || Platform.isIOS
                        ? null
                        : () async {
                            await controller.unsubscribeTopic();
                            setState(() {
                              subscribed = false;
                            });
                          },
                    child: const Text('Unsubscribe Topic'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.unsubscribeTopic();
    super.dispose();
  }
}
