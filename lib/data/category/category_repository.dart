import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../feature/shop/model/category_model.dart';
import '../../utils/exception/firebase_auth_exception.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //variable
  final _db = FirebaseFirestore.instance;

  //Get all categories
  Future<List<CategoryModel>> getAllCategory({
    bool? isFeature,
  }) async {
    try {
      final snapshot = await _db
          .collection("Categories")
          .where('IsFeatured', isEqualTo: true)
          .get();

      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }
}
