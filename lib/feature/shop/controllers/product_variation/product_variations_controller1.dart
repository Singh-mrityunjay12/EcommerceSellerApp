import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/widgets/loadders/loadders.dart';

class ProductVariationsController1 extends GetxController {
  static ProductVariationsController1 get instance => Get.find();

  TextEditingController variationsId1 = TextEditingController();
  final variationsStock1 = TextEditingController();
  final variationsPrice1 = TextEditingController();
  final variationsSalePrice1 = TextEditingController();
  final variationsDescriptions1 = TextEditingController();
  final variationsColor1 = TextEditingController();
  final variationsSize1 = TextEditingController();

  final ImagePicker _imagePicker1 = ImagePicker();
  final FirebaseStorage storageRef = FirebaseStorage.instance;
  final isLoading = false.obs;
  // final _db = FirebaseFirestore.instance;
  Rx<String> imageUrl1 = ''.obs;

  Rx<XFile> selectImage1 = XFile('').obs;
  final isActive = false.obs;

  // show image picker dialog

  Future<void> showImagePickerDialog1() async {
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
    XFile? imgs;
    if (type == 'gallery') {
      try {
        imgs = await _imagePicker1.pickImage(
            source: ImageSource.gallery, imageQuality: 80);
        update();
      } catch (e) {
        MLoader.customToast(message: 'Something went wrong $e');
      }
    } else {
      final img = await _imagePicker1.pickImage(
          source: ImageSource.camera, imageQuality: 80);
      if (img != null) {
        imgs = img;
        update();
      }
    }

    if (imgs != '') {
      selectImage1.value = imgs!;
      update();
    }
  }

  void toggleIsFeature(bool value) {
    isActive.value = value;
    print("//////////////////////////$isActive");
    update();
  }

  //Add images url in storage

  Future<void> uploadVariationFunction1(XFile _images) async {
    dynamic imageUrl = await uploadFile(_images);
    imageUrl1.value = imageUrl;
    update();
  }

  Future<String> uploadFile(XFile _image) async {
    TaskSnapshot reference = await storageRef
        .ref()
        .child('Products1/Images')
        .child(variationsId1.text.trim())
        .putFile(File(_image.path));
    return await reference.ref.getDownloadURL();
  }
}
