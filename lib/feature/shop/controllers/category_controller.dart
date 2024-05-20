import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/widgets/Network/network_manager.dart';
import '../../../common/widgets/loadders/loadders.dart';
import '../../../data/category/category_repository.dart';
import '../../../utils/exception/firebase_auth_exception.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();
  final ImagePicker _imagePicker = ImagePicker();
  // XFile selectImage = XFile('');
  final FirebaseStorage storageRef = FirebaseStorage.instance;

  final _db = FirebaseFirestore.instance;
  Rx<String> imageUrl1 = ''.obs;
  Rx<XFile> selectImage = XFile('').obs;
  //Variable

  final id = TextEditingController();
  final name = TextEditingController();
  final isFeature = false.obs;
  final isLoading = false.obs;
  GlobalKey<FormState> categoryKey =
      GlobalKey<FormState>(); //Form key for validation

  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;

  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }
//Load Category data

  Future<void> fetchCategories() async {
    try {
      //Show loader while loading categories
      // loading.value = true;

      //Fetch categories from data source (Firestore ,Api etc.)
      final categories = await _categoryRepository.getAllCategory();

      //Update the categories list
      allCategories.assignAll(categories);
      //Filter featured categories
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // show image picker dialog

  Future<void> showImagePickerDialog() async {
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
        imgs = await _imagePicker.pickImage(
            source: ImageSource.gallery, imageQuality: 80);
        update();
      } catch (e) {
        MLoader.customToast(message: 'Something went wrong $e');
      }
    } else {
      final img = await _imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 80);
      if (img != null) {
        imgs = img;
        update();
      }
    }

    if (imgs != '') {
      selectImage.value = imgs!;
      update();
    }
  }

  void toggleIsFeature(bool value) {
    isFeature.value = value;
    print("//////////////////////////$isFeature");
    update();
  }

  //Add images url in storage

  Future<void> uploadFunction(XFile _images) async {
    dynamic imageUrl = await uploadFile(_images);
    imageUrl1.value = imageUrl;
    update();
  }

  Future<String> uploadFile(XFile _image) async {
    TaskSnapshot reference = await storageRef
        .ref()
        .child('Categories')
        .child(name.text.trim())
        .putFile(File(_image.path));
    return await reference.ref.getDownloadURL();
  }

  Future<void> uploadCategory() async {
    try {
      isLoading.value = true;
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //isConnected is false means no Internet then stop the loading
        return;
      }

      //Form Validation
      if (!categoryKey.currentState!.validate()) {
        return;
      }
      // //Upload Image and Get's its Url

      await uploadFunction(selectImage.value);

      CategoryModel categoryModel = CategoryModel(
          id: id.text.trim(),
          name: name.text.trim(),
          image: imageUrl1.value,
          isFeatured: isFeature.value);

      //Data add in FirebaseFirestore

      await _db
          .collection('Categories')
          .doc(categoryModel.id)
          .set(categoryModel.toJson());

      isLoading.value = false;

      MLoader.successSnackBar(title: "Successfully Loaded Category");
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }

  //Load Category data

  Future<List<CategoryModel>> fetchCategories1() async {
    try {
      //Show loader while loading categories

      //Fetch categories from data source (Firestore ,Api etc.)
      final categories = await _categoryRepository.getAllCategory(
        isFeature: true,
      );

      return categories;
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
