import 'package:admin_panel/common/widgets/loadders/loadders.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import 'category_controller.dart';

class CategoryDropDownController extends GetxController {
  static CategoryDropDownController get instance => Get.find();
  //variable
  final _db = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

  final controller = Get.put(CategoryController());

  RxString? selectedCategoryId;
  RxString? selectedCategoryName;

  @override
  void onInit() {
    super.onInit();
    // fetchCategories1();
    fetchCategory2();
  }

  Future<void> fetchCategory2() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _db.collection("Categories").get();

      List<Map<String, dynamic>> categoryList1 = [];
      querySnapshot.docs
          .forEach((DocumentSnapshot<Map<String, dynamic>> category) {
        if (category['IsFeatured'] && category['ParentId'].isEmpty)
          categoryList1.add({
            'categoryId': category.id,
            'categoryName': category['Name'],
            'categoryImage': category['Image']
          });
      });

      categories.value = categoryList1;
      update();
    } catch (e) {
      MLoader.errorSnackBar(title: "oh1 Snap", message: e.toString());
    }
  }

  Future<void> fetchCategories1() async {
    try {
      final result = controller.featuredCategories;
      List<Map<String, dynamic>> categoryList = [];

      for (var element in result) {
        categoryList.add({
          'categoryId': element.id,
          'categoryName': element.name,
          'categoryImage': element.image
        });
      }

      categories.value = categoryList;
      update(); //isaka use karane ye fayada hota h ki jo bhi cheaj hamane kiya h vo sab update rahe h
    } catch (e) {
      MLoader.errorSnackBar(title: "oh2 Snap", message: e.toString());
    }
  }

  //set selected category

  void setSelectedCategory(String? categoryId) {
    selectedCategoryId = categoryId?.obs;
    print("selected category id: $selectedCategoryId");
    update();
  }

  //fetch category name
  Future<String?> getCategoryName(String? categoryId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection("Categories").doc(categoryId).get();
      if (snapshot.exists) {
        print("RAM");
        final result = snapshot.data()!;
        return result['Name'];
      } else {
        return '';
      }
    } catch (e) {
      // MLoader.errorSnackBar(title: "oh3 Snap", message: e.toString());
      return '';
    }
  }

  //set category name
  Future<void> setCategoryName(String? categoryName) async {
    selectedCategoryName = categoryName?.obs;
    print("select category name: $selectedCategoryName");
    update();
  }
}
