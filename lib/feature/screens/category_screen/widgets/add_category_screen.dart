import 'dart:io';

import 'package:admin_panel/common/widgets/appbar/appbar.dart';
import 'package:admin_panel/feature/shop/controllers/category_controller.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Scaffold(
      appBar: const MAppBar(
        title: Text("Add Category Screen"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.spaceBtwItems),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Category Image",
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                      height: 52,
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: ElevatedButton(
                          onPressed: () {
                            controller.showImagePickerDialog();
                          },
                          child: const Text("Select Images"))),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              //Add Category image

              GetBuilder<CategoryController>(
                  init: CategoryController(),
                  builder: (categoryController) {
                    return categoryController.selectImage != ''
                        ? Container(
                            height: Get.height / 3.7,
                            width: MediaQuery.of(context).size.width - 20,
                            child: Stack(
                              children: [
                                Image.file(
                                  File(categoryController
                                      .selectImage.value.path),
                                  fit: BoxFit.cover,
                                  height: Get.height / 4,
                                  width: Get.width / 2,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox();
                  }),

              Form(
                key: controller.categoryKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.name,
                      validator: (value) =>
                          MValidator.validateEmptyText("Category_Name", value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: MTexts.categoryName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(
                      height: MSizes.spaceBtwItems,
                    ),
                    TextFormField(
                      controller: controller.id,
                      validator: (value) =>
                          MValidator.validateEmptyText("Category_Id", value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: MTexts.categoryId,
                          prefixIcon: Icon(Iconsax.dcube)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: MSizes.spaceBtwItems,
              ),
              //Is Feature
              GetBuilder<CategoryController>(
                  init: CategoryController(),
                  builder: (controller) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Is_Feature',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Switch(
                              value: controller.isFeature.value,
                              onChanged: (value) {
                                controller.toggleIsFeature(value);
                                print(value);
                              })
                        ],
                      ),
                    );
                  }),

              const SizedBox(
                height: MSizes.spaceBtwItems,
              ),

              Obx(() => SizedBox(
                  width: double.infinity,
                  child: controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : ElevatedButton(
                          onPressed: () {
                            controller.uploadCategory();
                          },
                          child: const Text("Upload Category"))))
            ],
          ),
        ),
      ),
    );
  }
}
