import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loadders.dart';
import '../../../../data/pending/pending_repository.dart';

class PendingController extends GetxController {
  static PendingController get instance => Get.find();

  final isLoading = false.obs;
  final pendingRepository = Get.put(PendingRepository());

  //Update field of the firebase

  void updateField(String status, String uuid, String userId) async {
    try {
      if (status != '') {
        isLoading.value = true;
        await pendingRepository.updateField(uuid, userId, status);

        isLoading.value = false;

        MLoader.successSnackBar(
            title: "Congratulations",
            message: "Your Profile Image has been uploaded");
      }
    } catch (e) {
      print("//////////////////////////////wrong");
      MLoader.errorSnackBar(
          title: "Oh Snap!", message: "Something went wrong:$e");
    } finally {
      print("//////////////////////////////right");
      isLoading.value = false;
    }
  }
}
