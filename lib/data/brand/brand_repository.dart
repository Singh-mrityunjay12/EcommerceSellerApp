import 'package:admin_panel/feature/shop/controllers/brand_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../feature/shop/model/brand_model.dart';
import '../../utils/exception/firebase_auth_exception.dart';
import '../../utils/exception/formate_exceptions.dart';
import '../../utils/exception/platform_exceptions.dart';

class BrandRepository extends GetxController {
  static BrandController get instance => Get.find();

  //variable
  final _db = FirebaseFirestore.instance;
  final isLoading = false.obs;

  //Get all Categories

  Future<List<BrandModel>> getAllBrands() async {
    try {
      //Query of cloud FirebaseFirestore
      final snapshot = await _db.collection('Brands').get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      print("///////////////////////////////////////wrong");
      throw 'Something went wrong .while fetching Brands';
    }
  }
}
