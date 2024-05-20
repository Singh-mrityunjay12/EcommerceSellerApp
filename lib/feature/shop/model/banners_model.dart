import 'package:cloud_firestore/cloud_firestore.dart';

class BannersModel {
  String imageUrl;
  final String targetScreen;
  final String name;
  final bool active;

  BannersModel(
      {required this.imageUrl,
      required this.targetScreen,
      required this.name,
      required this.active});

  //static function to create an empty user model
  static BannersModel empty() =>
      BannersModel(imageUrl: '', targetScreen: '', name: '', active: false);

  Map<String, dynamic> toJson() {
    return {
      'ImageUrl': imageUrl,
      'TargetScreen': targetScreen,
      'BannerName': name,
      'Active': active
    };
  }

  factory BannersModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    // final data = snapshot.data() as Map<String, dynamic>;
    if (document.data() != null) {
      final data = document.data()!;
      return BannersModel(
          imageUrl: data['ImageUrl'] ?? '',
          targetScreen: data['TargetScreen'] ?? '',
          name: data['BannerName'] ?? '',
          active: data['Active'] ?? false);
    } else {
      return BannersModel.empty();
    }
  }
}
