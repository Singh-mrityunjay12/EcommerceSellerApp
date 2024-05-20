import 'package:get/get.dart';

class IsSaleController extends GetxController {
  static IsSaleController get instance => Get.find();
  RxBool isSale = false.obs;

  void toggleIsSale(bool value) {
    isSale.value = value;
    update();
  }

  void setIsSaleOldValue(bool value) {
    isSale.value = value;
    update();
  }
}
