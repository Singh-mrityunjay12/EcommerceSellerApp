import 'dart:io';
import 'package:admin_panel/common/widgets/appbar/appbar.dart';
import 'package:admin_panel/feature/shop/controllers/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';

class AddBannerScreen extends StatelessWidget {
  const AddBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Scaffold(
      appBar: const MAppBar(
        title: Text("Add Banner Screen"),
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
                    "Select Banner Image",
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
                height: MSizes.spaceBtwItems,
              ),

              //Add Category image

              GetBuilder<BannerController>(
                  init: BannerController(),
                  builder: (bannerController) {
                    return bannerController.selectImage != ''
                        ? Container(
                            height: Get.height / 3.7,
                            width: MediaQuery.of(context).size.width - 20,
                            child: Stack(
                              children: [
                                Image.file(
                                  File(bannerController.selectImage.value.path),
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
                  key: controller.bannerFormKey,
                  child: Column(children: [
                    TextFormField(
                      controller: controller.bannerName,
                      validator: (value) =>
                          MValidator.validateEmptyText("Banner_Name", value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: MTexts.bannerName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                  ])),

              const SizedBox(
                height: MSizes.spaceBtwItems,
              ),
              //Is Feature
              GetBuilder<BannerController>(
                  init: BannerController(),
                  builder: (controller) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Is_Active',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Switch(
                              value: controller.isActive.value,
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
                            controller.uploadBanner();
                          },
                          child: const Text("Upload Banner"))))
            ],
          ),
        ),
      ),
    );
  }
}
