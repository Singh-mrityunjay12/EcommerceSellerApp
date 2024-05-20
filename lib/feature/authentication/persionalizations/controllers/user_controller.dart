import 'package:get/get.dart';

import '../../../../common/widgets/loaders/loadders.dart';
import '../../../../data/repository/user_model/user_model.dart';
import '../../../../data/repository/users/user_repository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());

  final RxList<UserModel> userName = <UserModel>[].obs;
  final isSearching = true.obs;

  final Rx<int> userCollectionLength = Rx<int>(0);
  final isLoading = false.obs;

  @override
  void onInit() {
    calculateTotalUsers();
    super.onInit();
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final result = await userRepository.fetchAllUsers();
      storeUserName(result);
      return result;
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  void calculateTotalUsers() async {
    isLoading.value = true;
    final result = await userRepository.fetchAllUsers();

    if (result.isNotEmpty) {
      userCollectionLength.value = result.length;
    } else {
      userCollectionLength.value = 4;
    }
    isLoading.value = false;
  }

  void storeUserName(List<UserModel> users) {
    userName.clear();
    userName.addAll(users);
  }

  //filter data
  Future<void> runFilter(String enteredKeyword) async {
    try {
      final result = await userRepository.fetchAllUsers();
      if (enteredKeyword.isEmpty) {
        // if the search field is empty or only contains white-space, we'll display all users
        if (userName.isEmpty) {
          userName.addAll(result);
        } else {
          for (var i = 0; i < result.length; i++) {
            if (userName[i].fullName.toLowerCase() ==
                result[i].fullName.toLowerCase()) {
              print("hhhh");
            } else {
              userName.add(result[i]);
            }
          }
        }
      } else {
        final result1 = result
            .where((user) => user.fullName
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
        userName.addAll(result1);

        // we use the toLowerCase() method to make it case-insensitive
      }
    } catch (e) {
      MLoader.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
