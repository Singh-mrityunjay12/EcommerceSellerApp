import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loadders.dart';
import '../../../../data/orders/order_repository.dart';
import '../../model/order_model.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  final orderRepository = Get.put(OrderRepository());

  final isLoading = false.obs;

  //Fetch user order history
  Future<List<OrderModel>> fetchUsersOrders() async {
    try {
      // isloading.value = true;
      print('////////////////////////////////////////Q');

      final usersOrders = await orderRepository.fetchUserOrders();
      print(usersOrders.length);

      print('////////////////////////////////////////R');
      // isloading.value = false;
      return usersOrders;
    } catch (e) {
      MLoader.warningSnackBar(title: 'Oh No', message: e.toString());
      return [];
    }
  }

  //Fetch Order from user

  Future<List<OrderModel>> fetchUsersOrders1(String userId) async {
    try {
      print('////////////////////////////////////////Q');
      final usersOrders = await orderRepository.fetchUserOrders1(userId);
      print('////////////////////////////////////////R');
      return usersOrders;
    } catch (e) {
      MLoader.warningSnackBar(title: 'Oh Mrityunjay', message: e.toString());
      return [];
    }
  }

  //Update field of the firebase

  void updateField(String status, String uuid, String userId) async {
    try {
      if (status != '') {
        isLoading.value = true;
        await orderRepository.updateField(uuid, userId, status);

        isLoading.value = false;

        MLoader.successSnackBar(
            title: "Congratulations",
            message: "Your Profile Image has been uploaded");
      }
    } catch (e) {
      print("//////////////////////////////wrong");
      MLoader.errorSnackBar(
          title: "Oh Singh!", message: "Something went wrong:$e");
    } finally {
      print("//////////////////////////////right");
      isLoading.value = false;
    }
  }
}
