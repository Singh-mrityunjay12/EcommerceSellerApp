import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../feature/shop/model/banners_model.dart';
import '../../utils/exception/firebase_auth_exception.dart';
import '../../utils/exception/formate_exceptions.dart';
import '../../utils/exception/platform_exceptions.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //Get all order related to current User

  Future<List<BannersModel>> fetchBanners1() async {
    try {
      final result = await _db
          .collection('Banners')
          .where('Active', isEqualTo: true)
          .get();
      final list = result.docs
          .map((document) => BannersModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }
}
