import 'package:admin_panel/feature/shop/controllers/category_dropdown_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownCategoryWidget extends StatelessWidget {
  const DropDownCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDropDownController>(
        init: CategoryDropDownController(),
        builder: (categoryDropDownController) {
          return Column(
            children: [
              Container(
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value:
                          categoryDropDownController.selectedCategoryId?.value,
                      items:
                          categoryDropDownController.categories.map((element) {
                        print('////////////////////////////////lenght');
                        print(categoryDropDownController.categories.length);
                        print('////////////////////////////////lenght');
                        return DropdownMenuItem<String>(
                            value: element.toString(),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      element['categoryImage'].toString()),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Text(element['categoryName'].toString())
                              ],
                            ));
                      }).toList(),
                      onChanged: (String? selectedValue) async {
                        categoryDropDownController
                            .setSelectedCategory(selectedValue);
                        String? categoryName = await categoryDropDownController
                            .getCategoryName(selectedValue);
                        await categoryDropDownController
                            .setCategoryName(categoryName);
                      },
                      hint: const Text("Select a Category"),
                      isExpanded: true,
                      elevation: 10,
                      underline: const SizedBox.shrink(),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
