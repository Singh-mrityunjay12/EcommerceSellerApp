import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/exception/firebase_auth_exception.dart';

class MFirebaseStorageService extends GetxController {
  static MFirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  //Upload Local Assets from IDE
  //Returns a Uint8List containing image data

  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      print('//////////////////////////////////////////1111');
      print(path);
      ByteData byteData = await rootBundle.load(path);
      print('//////////////////////////////////////////2222');
      Uint8List imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      //Handle exceptions gracefully
      print('//////////////////////////////////////////1wwwwww1');
      throw 'Error loading image data: $e';
    }
  }

  //Upload image using ImageData on the Cloud Firebase Storage
  //Return the download URL of the uploaded image
  //In this image file take from asset
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = _firebaseStorage.ref(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }

  //Upload Image on cloud firebase storage
  //Return the download url of the upload image
  //In this image take from galary,camera etc
  Future<String> uploadImageFile(String path, XFile image) async {
    try {
      final ref = _firebaseStorage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }
}
