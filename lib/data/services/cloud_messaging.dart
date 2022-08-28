import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';

typedef MessageHandler = Future<void> Function(RemoteMessage message);
typedef MessageOpenedAppHandler = Future<void> Function(RemoteMessage message);

class CloudMessagingService {
  static final _instance = CloudMessagingService._internal();
  late final FirebaseMessaging _messaging;

  CloudMessagingService._internal() : _messaging = FirebaseMessaging.instance;

  static CloudMessagingService get instance => _instance;

  String get _channelId => /* TODO define el id del canal que se usara */;

  Future<String?> get deviceToken => _messaging.getToken();

  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
  }) async {
    /* TODO solicita el permiso para mostrar notificaciones */

  }

  Future<void> initChannel() async {
    /* TODO registra el canal que se usara usando [FlutterNotificationChannel] */
  }

  void registerHandlers(
      {required BackgroundMessageHandler onBackground,
      required MessageHandler onMessage,
      MessageOpenedAppHandler? onOpenedApp}) {
    FirebaseMessaging.onBackgroundMessage(onBackground);
    FirebaseMessaging.onMessage.listen(onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(onOpenedApp);
  }

  Future<void> setNotificationPresentationOptions(
      {bool alert = false, bool badge = false, bool sound = false}) async {
    /* TODO set presentation options for iOS */
  }

  Future<void> subscribeToTopic({required String topic}) async {
    /* TODO suscribe el app a [topic] */
  }

  Future<void> unsubscribeFromTopic({required String topic}) async {
    /* TODO desuscribe el app a [topic] */
  }
}
