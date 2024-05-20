import 'package:get/get.dart';

import '../../../feature/screens/home_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  @override
  void onInit() {
    screenRedirect();

    super.onInit();
  }

  void screenRedirect() async {
    Future.delayed(const Duration(seconds: 2), () async {
      Get.to(() => const HomeScreen());
    });
  }
}
