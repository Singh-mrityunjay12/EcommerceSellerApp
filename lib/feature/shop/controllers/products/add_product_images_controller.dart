import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/widgets/loaders/loadders.dart';

class AddProductsImagesController extends GetxController {
  static AddProductsImagesController get instance => Get.find();

  final ImagePicker _imagePicker = ImagePicker();

  RxList<XFile> selectImages = <XFile>[].obs;

  final RxList<String> arrImagesUrl = <String>[].obs;

  final FirebaseStorage storageRef = FirebaseStorage.instance;

  Future<void> showImagesPickerDialog() async {
    PermissionStatus status;

    DeviceInfoPlugin deviceInfoPlugin =
        DeviceInfoPlugin(); //this is check the version of android so that we can easily excess images from android phone easily
    //without any faces deficulties
    AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

    //Now Check the Version of android which that can give us permission to excess the images from gallery or camera
    //Here 32 means 12 android version phone
    if (androidDeviceInfo.version.sdkInt <= 32) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.mediaLibrary.request();
    }

    //Now here give permission to excess gallery or camera
    if (status == PermissionStatus.granted) {
      Get.defaultDialog(
          title: 'Choose Images',
          middleText: 'Pick an Images from the gallery or camera? ',
          actions: [
            SizedBox(
                height: 53,
                width: 140,
                child: ElevatedButton(
                    onPressed: () {
                      selectImages1('camera');
                      Get.back();
                    },
                    child: const Text('Camera'))),
            SizedBox(
                height: 53,
                width: 140,
                child: ElevatedButton(
                    onPressed: () {
                      selectImages1('gallery');
                      Get.back();
                    },
                    child: const Center(child: Text('Gallery'))))
          ]);
    }

    if (status == PermissionStatus.denied) {
      MLoader.errorSnackBar(
          title: 'Error please allow permission for further usage');
      openAppSettings();
    }

    if (status == PermissionStatus.permanentlyDenied) {
      MLoader.errorSnackBar(
          title: 'Error please allow permission for further usage');
      openAppSettings();
    }
  }

  Future<void> selectImages1(String type) async {
    List<XFile> imgs = [];
    if (type == 'gallery') {
      try {
        imgs = await _imagePicker.pickMultiImage(imageQuality: 80);
        update();
      } catch (e) {
        MLoader.customToast(message: 'Something went wrong $e');
      }
    } else {
      final img = await _imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 80);
      if (img != null) {
        imgs.add(img);
        update();
      }
    }

    if (imgs.isNotEmpty) {
      selectImages.addAll(imgs);
      update();
    }
  }

  void removeImages(int index) {
    selectImages.removeAt(index);
    update();
  }

  //Add images url in storage

  Future<void> uploadProductFunction(List<XFile> _images) async {
    arrImagesUrl.clear();

    for (int i = 0; i < _images.length; i++) {
      dynamic imageUrl = await uploadFile(_images[i]);

      arrImagesUrl.add(imageUrl.toString());
    }
    update();
  }

  Future<String> uploadFile(XFile _image) async {
    TaskSnapshot reference = await storageRef
        .ref()
        .child('product-images')
        .child(_image.name + DateTime.now().toString())
        .putFile(File(_image.path));
    return await reference.ref.getDownloadURL();
  }
}
