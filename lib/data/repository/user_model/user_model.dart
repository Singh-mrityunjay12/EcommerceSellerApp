import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formattors.dart';

class UserModel {
  //keep those value final which you do not  want to update

  final String id;
  final String token;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  //Constructor for UserModel
  UserModel(
      {required this.id,
      required this.token,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture});

  //Helper function to get full name
  String get fullName => '$firstName $lastName';
  //Helper function to formate phone Number
  String get formatePhoneNumber => MFormatter.formatPhoneNumber(phoneNumber);
  //Static function to split full name into first and last' Name
  static List<String> nameParts(fullName) => fullName.split(" ");

  //static function to generate a username  from the full name
  static String generateUserName(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUserName =
        "$firstName$lastName"; //Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUserName"; //Add "cwt_" prefix
    return usernameWithPrefix;
  }

  //static function to create an empty user model
  static UserModel empty() => UserModel(
      id: "",
      token: "",
      firstName: "",
      lastName: "",
      username: "",
      email: "",
      phoneNumber: "",
      profilePicture: "");

  //Convert model to JSON  structure for sharing data in firebase
  Map<String, dynamic> toJson() {
    return {
      "FirstName": firstName,
      "Token": token,
      "LastName": lastName,
      "UserName": username,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "ProfilePicture": profilePicture
    };
  }

  //Factory method to create a UserModel from firebase documentSnapshot

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          token: data["Token"] ?? "",
          firstName: data["FirstName"] ?? "",
          lastName: data["LastName"] ?? "",
          username: data["UserName"] ?? "",
          email: data["Email"] ?? "",
          phoneNumber: data["PhoneNumber"] ?? "",
          profilePicture: data["ProfilePicture"] ?? "");
    }
    return UserModel.empty();
  }
}
