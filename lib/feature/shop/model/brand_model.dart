// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel(
      {required this.id,
      required this.name,
      required this.image,
      this.isFeatured,
      this.productsCount});

  //Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  //Convert model to json structure so that you can store data in Firebase

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured
    };
  }

  //Map json oriented document snapshot from Firebase to UserModel

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? '',
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: int.parse((data['ProductsCount'] ?? 0).toString()));
  }

  //Map json oriented document snapshot from Firebase to UserModel
  factory BrandModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      //Map JSON Record to the Model
      return BrandModel(
          id: document.id,
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          isFeatured: data['IsFeatured'] ?? false,
          productsCount: data['ProductsCount'] ?? '');
    } else {
      return BrandModel.empty();
    }
  }
}
