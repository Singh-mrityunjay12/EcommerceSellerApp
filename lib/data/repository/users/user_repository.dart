import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../user_model/user_model.dart';

class UserRepository extends GetxController {
  final _db = FirebaseFirestore.instance;

  //Fetch all user

  Future<List<UserModel>> fetchAllUsers() async {
    try {
      final result = await _db.collection('Users').get();
      return result.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Something went wrong while featching Address Information . Try again later';
    }
  }
}
