import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

class FormStateController extends State<Form> {
  static FormStateController get instance => Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  static GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  static GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  static GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  static GlobalKey<FormState> formKey4 = GlobalKey<FormState>();
  static GlobalKey<FormState> formKey5 = GlobalKey<FormState>();
}
