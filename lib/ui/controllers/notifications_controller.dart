import 'package:f_notifications/domain/use_cases/cloud_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  Future<void> initialize(
      {required String androidFavicon, required Color color}) async {
    /* TODO Inicializa el administrador de notificaciones */
  }

  Future<void> subscribeTopic() async {
    /* TODO Agrega la suscripcion al tema 'flutter_messages' */
  }

  Future<void> unsubscribeTopic() async {
    /* TODO Elimina la suscripcion al tema 'flutter_messages' */
  }

  Future<void> showLocalNotification(
      {required String title, required String content}) async {
    /* TODO Crea una instancia de [RemoteMessage] y muestrala usando .displayFunction() */
  }
}
