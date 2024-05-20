import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../../screens/users/user_screen.dart';

class FirebaseNotificationController extends GetxController {
  static FirebaseNotificationController get instance => Get.find();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    if (Platform.isIOS) {
      await messaging.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true);
    }
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // MLoader.successSnackBar(
      //     title: "user granted permissions", message: "Success");
      print("user granted permissions");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // MLoader.successSnackBar(
      //     title: 'user granted provisional permissions',
      //     message: 'Provisional');
      print('user granted provisional permissions');
    } else {
      // MLoader.errorSnackBar(title: 'user denied permissions', message: 'error');
      print('user denied permissions');
    }
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      print("notifications title:${notification!.title}");
      print("notifications body:${notification.body}");
      print('count:${android!.count}');
      print('data:${message.data.toString()}');
      print(message.data['type']);
      print(message.data['id']);

      if (Platform.isIOS) {
        forGroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  //function to initialize flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    //RemoteMessage come from firebase
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInitializationSettings = const DarwinInitializationSettings(); //For Ios

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    print("In Handle message function");

    if (message.data['type'] == 'msg') {
      //redirect to new screen or take different action based on payload that you received
      Get.to(() => const UserScreen());
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
            message.notification!.android!.channelId.toString(),
            message.notification!.android!.channelId.toString(),
            importance: Importance.max,
            showBadge: true,
            playSound: true);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(androidNotificationChannel.id.toString(),
            androidNotificationChannel.name.toString(),
            channelDescription: "Flutter Notifications",
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            playSound: true,
            sound: androidNotificationChannel.sound);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  //Har device ka apana ak token hota h aur us token ke uper firebase notification bhejata h firebase user ke uid pe notification nahi bhejata h
  //firebase notification bhejata h user ke device ke token ke uper
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

//It is use to refresh the token or update the token
  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print(
          "Token Refreshed///////////////////////////////////////////////////////");
    });
  }

  Future forGroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }
}
