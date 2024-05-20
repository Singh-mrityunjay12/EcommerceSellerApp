import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../utils/formatters/formattors.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectAddress;

  AddressModel(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.street,
      required this.city,
      required this.state,
      required this.postalCode,
      required this.country,
      this.dateTime,
      this.selectAddress = true});

  String get formatePhoneNo => MFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
      id: '',
      name: '',
      phoneNumber: '',
      street: '',
      city: '',
      state: '',
      postalCode: '',
      country: '');

  //It is used to store the data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'DateTime': DateTime.now(),
      'SelectingAddress': selectAddress
    };
  }

  //fetch the data from firebase or Api
  factory AddressModel.fromMap(Map<String, dynamic> data) {
    print('/////////////////////////////////////');
    return AddressModel(
        id: data['Id'] as String,
        name: data['Name'] as String,
        phoneNumber: data['PhoneNumber'] as String,
        street: data['Street'] as String,
        city: data['City'] as String,
        state: data['State'] as String,
        postalCode: data['PostalCode'] as String,
        country: data['Country'] as String,
        selectAddress: data['SelectingAddress'] as bool,
        dateTime: (data['DateTime'] as Timestamp).toDate());
  }

  //factory constructor to create an AddressModel from a DocumentSnapshot
  factory AddressModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    print("///////////////////////////////////////right2");
    if (document.data() == null) return AddressModel.empty();
    final data = document.data()!;
    print("///////////////////////////////////////right3");
    return AddressModel(
        id: document.id,
        name: data['Name'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        street: data['Street'] ?? '',
        city: data['City'] ?? '',
        state: data['State'] ?? '',
        postalCode: data['PostalCode'] ?? '',
        country: data['Country'] ?? '',
        dateTime: (data['DateTime'] as Timestamp).toDate(),
        selectAddress: data['SelectingAddress'] as bool);
  }

  @override
  String toString() {
    return '$street, $city, $state $postalCode, $country';
  }
}
