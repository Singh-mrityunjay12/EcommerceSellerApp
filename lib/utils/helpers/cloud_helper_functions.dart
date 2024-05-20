import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../exception/firebase_auth_exception.dart';
import '../exception/formate_exceptions.dart';
import '../exception/platform_exceptions.dart';

class MCloudHelperFunction {
  //Helper function to check the state of a single database record
  //Return a Widget based on the state of the snapshot
  //If data is still loading ,it returns a CircularProgressIndicator
  //If data is found ,it returns a generic 'No Data Found' message
  //If an error occurs, it return a generic error message
  //Otherwise it return null.

  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null) {
      return const Center(
        child: Text("No Data Found!"),
      );
    }
    if (snapshot.hasError) {
      return const Center(
        child: Text("Something went wrong"),
      );
    }
    return null;
  }

  //Helper function to check the state of the multiple (list) database records.
  //Return a widgets based on the state of the snapshot
  //if data still loading, it returns a CircularProgressIndicator
  //If no data is found, it returns a generic "No Data Found" message or a custom nothingFoundWidget if provided
  //If an error occurs, it return a generic error message
  //Otherwise it return null.

  static Widget? checkMultiRecordState<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(
        child: Text("No Data Found!"),
      );
    }
    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(
        child: Text("Something went wrong"),
      );
    }
    return null;
  }

  //Create a reference with initial file path and name and retrieve the download URL

  static Future<String> getURLFoundFilePathName(String path) async {
    try {
      if (path.isEmpty) return '';
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      print("///////////////////////////////////////wrong");
      throw 'Something went wrong .Please try again';
    }
  }
}
