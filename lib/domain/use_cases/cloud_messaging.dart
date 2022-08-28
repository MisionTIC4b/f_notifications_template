import 'dart:io';
import 'dart:ui';
import 'package:f_notifications/data/services/cloud_messaging.dart';
import 'package:f_notifications/device/local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class CloudMessagingManager {
  static final CloudMessagingService _service = CloudMessagingService.instance;
  static final LocalNotificationManager _manager =
      LocalNotificationManager.instance;

  static Future<String?> get deviceToken => _service.deviceToken;

  static Future<void> init(
      {required String androidFavicon, required Color color}) async {
    initChannel();
    if (Platform.isAndroid) {
      initializeLocalNotifications(androidFavicon: androidFavicon);
    }
    if (Platform.isIOS) {
      final settings = await requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Needed to show heads-up notification when app is open
        await setNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }
    }
    registerHandlers(
        onBackground: _onBackgroundHandler,
        onMessage: (message) => _onMessageHandler(color, message));
  }

  static Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
  }) async {
    return await _service.requestPermission(
      alert: alert,
      announcement: announcement,
      badge: badge,
      carPlay: carPlay,
      criticalAlert: criticalAlert,
      provisional: provisional,
      sound: sound,
    );
  }

  static Future<void> initChannel() async {
    await _service.initChannel();
  }

  static Future<void> initializeLocalNotifications(
      {required String androidFavicon}) async {
    await _manager.initializeLocalNotifications(androidFavicon: androidFavicon);
  }

  static void registerHandlers(
      {required BackgroundMessageHandler onBackground,
      required MessageHandler onMessage,
      MessageOpenedAppHandler? onOpenedApp}) {
    _service.registerHandlers(onBackground: onBackground, onMessage: onMessage);
  }

  static Future<void> setNotificationPresentationOptions(
      {bool alert = false, bool badge = false, bool sound = false}) async {
    await _service.setNotificationPresentationOptions(
        alert: alert, badge: badge, sound: sound);
  }

  static Future<void> displayNotification(
      {required Color color, required RemoteMessage message}) async {
    await _manager.displayNotification(color: color, message: message);
  }

  static Future _onBackgroundHandler(RemoteMessage message) async {
    /* print('onBackgroundHandler\nMessage: ${message.notification?.title ?? ''}');
    print(message.data); */
  }

  static Future _onMessageHandler(Color color, RemoteMessage message) async {
    if (Platform.isAndroid) {
      displayNotification(color: color, message: message);
    }
  }

  static Future<void> subscribeToTopic({required String topic}) async {
    await _service.subscribeToTopic(topic: topic);
  }

  static Future<void> unsubscribeFromTopic({required String topic}) async {
    await _service.unsubscribeFromTopic(topic: topic);
  }
}
