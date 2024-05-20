import 'package:admin_panel/common/widgets/loadders/loadders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../model/product_model.dart';

class ProductEditController extends GetxController {
  ProductModel productModel;
  ProductEditController({required this.productModel});
  static ProductEditController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  RxList<String> images = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRealTimeImages();
  }

  void getRealTimeImages() {
    _db
        .collection('Products')
        .doc(productModel.id)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data['Images'] != null) {
          images.value = List<String>.from(data['Images'] as List<dynamic>);
          update();
        }
      }
    });
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
  Future<void> deleteImageFromFireStore(
      String imageUrl, String productId) async {
    try {
      await _db.collection('Products').doc(productId).update({
        'Images': FieldValue.arrayRemove([imageUrl])
      });
      update();
    } catch (e) {
      MLoader.errorSnackBar(title: 'Update Image', message: e.toString());
    }
  }
}
