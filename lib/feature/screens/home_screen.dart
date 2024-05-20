import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../../common/widgets/drawer/drawer_widget.dart';

import '../../utils/constants/colors.dart';
import '../authentication/persionalizations/models/firebase_notifications/firebase_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const ZoomDrawer(
      slideWidth: 300,
      menuScreen: DrawerWidget(),
      mainScreen: MainPage(),
      angle: 0,
      duration: Duration(milliseconds: 600),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  FirebaseNotificationController notifications =
      Get.put(FirebaseNotificationController());
  @override
  void initState() {
    super.initState();
    notifications.requestNotificationPermission();
    notifications.forGroundMessage();
    notifications.firebaseInit(context);

    print("........................................MRityunjay Singh");
    notifications.isTokenRefresh();

    print("////////////////////////////////////");
    notifications.getDeviceToken().then((value) {
      print("Device Token");
      print(value);
    });
    print("/////////////////////////////////////////");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MColors.golden,
        appBar: AppBar(
          title: const Text("Admin Panel"),
          backgroundColor: Colors.orange,
          leading: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: const Icon(Icons.menu)),
        ),
        body: Center(
            child: SizedBox(
          width: 250.0,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 35,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 7.0,
                  color: Colors.white,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText('Flicker Frenzy'),
                FlickerAnimatedText('Night Vibes On'),
                FlickerAnimatedText("Admin Pannel"),
              ],
              onTap: () {
                print("Tap Event");
              },
            ),
          ),
        ))
        // Center(
        //   child: TextButton(
        //       onPressed: () {
        //         notifications.getDeviceToken().then((value) async {
        //           var data = {
        //             'to': value.toString(),
        //             'priority': 'high',
        //             'notification': {
        //               'title': 'Mrityunjay Singh',
        //               'body': 'This Notification Developed By Mri'
        //             },
        //             'data': {'type': 'msg', 'id': 'mri@123'}
        //           };
        //           await http.post(
        //               Uri.parse('https://fcm.googleapis.com/fcm/send'),
        //               body: jsonEncode(data),
        //               headers: {
        //                 'Content-Type': 'application/json; charset=UTF-8',
        //                 'Authorization':
        //                     'key=AAAA1Bsv_PU:APA91bHAZl31XoJxBEY0VKI_cy7-gWJNozdyxYiHJzoRn7ttFqOgrG0WmUQANSh4EYsX__FJxgxVBKYfwvBMcwfJjoT9P6nRXyS8pSdFx0oBAOj2z6dKqqZEuUCywNGo4v5g5tBAx4fP'
        //               });
        //         });
        //       },
        //       child: const Text("Send Notification")),
        // ),
        );
  }
}


//Sender id means me
//(910989196533)
//Server key
//AAAA1Bsv_PU:APA91bHAZl31XoJxBEY0VKI_cy7-gWJNozdyxYiHJzoRn7ttFqOgrG0WmUQANSh4EYsX__FJxgxVBKYfwvBMcwfJjoT9P6nRXyS8pSdFx0oBAOj2z6dKqqZEuUCywNGo4v5g5tBAx4fP