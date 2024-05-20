import 'dart:io';
import 'package:admin_panel/feature/shop/model/brand_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../common/widgets/Network/network_manager.dart';
import '../../../common/widgets/loadders/loadders.dart';
import '../../../data/brand/brand_repository.dart';
import '../../../utils/exception/firebase_auth_exception.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  var brandName = TextEditingController();
  var brandId = TextEditingController();
  var productCount = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  // XFile selectImage = XFile('');
  final FirebaseStorage storageRef = FirebaseStorage.instance;
  final isLoading = false.obs;
  final _db = FirebaseFirestore.instance;
  Rx<String> imageUrl1 = ''.obs;
  Rx<XFile> selectImage = XFile('').obs;
  final isSelect = false.obs;
  final isFeature = false.obs;
  GlobalKey<FormState> brandFormKey =
      GlobalKey<FormState>(); //Form key for validation
  // show image picker dialog

  RxBool isLoading1 = false.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featureBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

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

  Future<void> uploadBrandFunction(XFile _images) async {
    dynamic imageUrl = await uploadFile(_images);
    imageUrl1.value = imageUrl;
    update();
  }

  Future<String> uploadFile(XFile _image) async {
    TaskSnapshot reference = await storageRef
        .ref()
        .child('Brand')
        .child(brandName.text.trim())
        .putFile(File(_image.path));
    return await reference.ref.getDownloadURL();
  }

  //Upload Brand

  Future<void> uploadBrand() async {
    try {
      isLoading.value = true;
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //isConnected is false means no Internet then stop the loading
        return;
      }

      //Form Validation
      if (!brandFormKey.currentState!.validate()) {
        return;
      }
      // //Upload Image and Get's its Url

      await uploadBrandFunction(selectImage.value);

      BrandModel brandModel = BrandModel(
        id: brandId.text.trim(),
        name: brandName.text.trim(),
        image: imageUrl1.value,
        isFeatured: isFeature.value,
        productsCount: int.parse(productCount.text.trim()),
      );

      await _db
          .collection('Brands')
          .doc(brandModel.id)
          .set(brandModel.toJson());

      isLoading.value = false;

      MLoader.successSnackBar(title: "Successfully Loaded Brand");
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }

  //Load Brands
  Future<List<BrandModel>> getFeaturedBrands() async {
    try {
      //Show Loader while loading Brand

      final brands = await brandRepository.getAllBrands();
      allBrands.assignAll(brands);
      print("/////////////////////${brands[0].name}");

      featureBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
      return brands;
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  //Delete Images From Storage
  Future deleteImageFromStorage(String imageUrl) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    try {
      Reference reference = storage.refFromURL(imageUrl);
      await reference.delete();
    } catch (e) {
      MLoader.errorSnackBar(title: e.toString());
    }
  }

  //Delete Images Form FirestoreFirebase means from Collection
  Future<void> deleteImageFromFireStore(String imageUrl, String brandId) async {
    try {
      await _db
          .collection('Brands')
          .doc(brandId)
          .update({'Images': FieldValue.delete()});
      update();
    } catch (e) {
      MLoader.errorSnackBar(title: 'Update Image', message: e.toString());
    }
  }
}
