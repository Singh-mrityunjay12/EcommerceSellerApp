import 'dart:convert';

import 'package:admin_panel/feature/authentication/persionalizations/models/firebase_notifications/firebase_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../common/widgets/Network/network_manager.dart';
import '../../../common/widgets/loadders/loadders.dart';
import '../../../common/widgets/popups/full_screen_loader.dart';

import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  NotificationController get instance => Get.find();

  final title = TextEditingController();
  final body = TextEditingController();
  RxBool refreshData = true.obs;

  GlobalKey<FormState> notificationFormKey = GlobalKey<FormState>();

  FirebaseNotificationController notificationController =
      FirebaseNotificationController.instance;
  //Add new address
  Future sendNotification({required String token}) async {
    try {
      //Start loading
      // MFullScreenLoader.openLoadingDialog(
      //     "Starting Address....", MImage.loadingGif);

      print("////////////////////////////////////////////////Mri");

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // MFullScreenLoader.stopLoading();
        return;
      }
      print("//////////////////////////////////////A");
      //Form validation
      if (!notificationFormKey.currentState!.validate()) {
        print("///////////////////////////////////////B");
        // MFullScreenLoader.stopLoading();
        return;
      }

      // //Save Address data
      notificationController.getDeviceToken().then((value) async {
        print("//////////////////////////////////MRisdfff");
        var data = {
          'to': token.toString(),
          'priority': 'high',
          'notification': {
            'title': title.text.trim(),
            'body': body.text.trim()
          },
          'data': {'type': 'msg', 'id': 'mri@123'}
        };
        print("/////////////////////////////////////////////chotooo");
        await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(data),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization':
                  'key=AAAA1Bsv_PU:APA91bHAZl31XoJxBEY0VKI_cy7-gWJNozdyxYiHJzoRn7ttFqOgrG0WmUQANSh4EYsX__FJxgxVBKYfwvBMcwfJjoT9P6nRXyS8pSdFx0oBAOj2z6dKqqZEuUCywNGo4v5g5tBAx4fP'
            });

        print("//////////////////////////////////////////////////////Bhai");
      });
      print("///////////////////////////////////////////////////////ABc");
      //Remove loader
      // MFullScreenLoader.stopLoading();
      //Show success message
      MLoader.successSnackBar(
          title: "Congratulations",
          message: 'Your address has been saved successfully');
      //Refresh Addresses data
      refreshData.toggle();

      //Reset fields
      // resetFormField();

      //Redirect
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   Navigator.of(Get.context!).push(MaterialPageRoute(
      //       builder: (_) => MSingleAddresses(address: address, onTap: () {})
      //       ));
      // });
      Navigator.of(Get.context!).pop();
      print("////////////////////////////kamr");
    } catch (e) {
      //Remove loader
      MFullScreenLoader.stopLoading();
      MLoader.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  //Functions to reset form field
  void resetFormField() {
    title.clear();
    body.clear();

    notificationFormKey.currentState!.reset();
  }
}
