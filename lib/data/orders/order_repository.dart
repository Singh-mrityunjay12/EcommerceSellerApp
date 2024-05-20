import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import '../../feature/shop/model/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  //Variable
  final _db = FirebaseFirestore.instance;

  // final FirebaseAuth auth = FirebaseAuth.instance;

  //Get all order related to current user

  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      // final userId = auth.currentUser!.uid;

      final result = await _db.collection('Orders').get();

      print(result.docs.length);
      print('////////////////////////////////////////T');
      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went to wrong while fetching Order Information. Try again letter';
    }
  }

  //Get all order related to all  user who are logged in

  Future<List<OrderModel>> fetchUserOrders1(String userId) async {
    try {
      if (userId.isEmpty) {
        throw 'Unable to find user information. Try again in few minutes';
      }
      print('////////////////////////////////////////H');
      final result =
          await _db.collection('Users').doc(userId).collection('Orders').get();
      print('////////////////////////////////////////T');

      return result.docs
          .map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot))
          .toList();
    } catch (e) {
      throw 'Something went to wrong while fetching Order Information. Try again letter';
    }
  }

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
      throw 'Something went to wrong while saving Order Information. Try again letter';
    }
  }
}
