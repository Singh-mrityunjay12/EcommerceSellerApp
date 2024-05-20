import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CancelledRepository extends GetxController {
  static CancelledRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //Update field of firebase

  Future<void> updateField(String uuid, String userId, String status) async {
    try {
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Orders')
          .doc(uuid)
          .update({'status': status, 'deliveryDate': DateTime.now()});
    } catch (e) {
      throw 'Something went to wrong while saving cancelled Information. Try again letter';
    }
  }
}
