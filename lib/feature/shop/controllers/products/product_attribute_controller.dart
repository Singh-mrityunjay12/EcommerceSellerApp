import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductAttributeController extends GetxController {
  static ProductAttributeController get instance => Get.find();

  final color1 = TextEditingController();
  final color2 = TextEditingController();
  final color3 = TextEditingController();
  final size1 = TextEditingController();
  final size2 = TextEditingController();
  final size3 = TextEditingController();
  GlobalKey<FormState> attributeFormKey =
      GlobalKey<FormState>(); //Form key for validation
}
