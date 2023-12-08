import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:we_hire/main.dart';
import 'package:we_hire/src/common_widget/interview_page_detail.dart';
import 'package:we_hire/src/common_widget/request_page.dart';
import 'package:we_hire/src/features/authentication/models/new_request.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title ?? 'No title'}');
  print('Body: ${message.notification?.body ?? 'No body'}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  HiringNew? hiringNew;

  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_notifications',
    'High Importance Notifications',
    description: "This channel is used for importance notifications",
    importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    initPushNotifications();
    initLocalNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    final routeId = int.tryParse(message.data['routeId']);
    final notificationType = (message.data['notificationType']).toString();
    if (routeId != null && notificationType != null) {
      if (notificationType == 'Hiring Request') {
        Navigator.push(
            navigatorKey.currentState!.context,
            MaterialPageRoute(
                builder: (context) => RequestPageDetail(routeId)));
      } else if (notificationType == 'Interview') {
        Navigator.push(
            navigatorKey.currentState!.context,
            MaterialPageRoute(
                builder: (context) => InterviewPageDetail(routeId)));
      }
    }
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((event) {
      final notification = event.notification;
      if (notification == null) return;
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
                _androidChannel.id, _androidChannel.name,
                channelDescription: _androidChannel.description,
                icon: '@drawable/ic_launcher')),
        payload: jsonEncode(event.toMap()),
      );
    });
  }

  Future initLocalNotifications() async {
    const ios = IOSInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android, iOS: ios);
    await _localNotifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        final decodedPayload = jsonDecode(payload!);
        final message = RemoteMessage(
          data: decodedPayload["data"],
          notification:
              null, // You may need to set the notification property based on your payload structure
        );
        handleMessage(message);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }
}
