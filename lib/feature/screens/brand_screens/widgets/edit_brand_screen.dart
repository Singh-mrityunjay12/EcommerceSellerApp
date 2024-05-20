import 'dart:io';

import 'package:admin_panel/common/widgets/appbar/appbar.dart';
import 'package:admin_panel/common/widgets/texts/section_heading.dart';
import 'package:admin_panel/feature/shop/controllers/brand_controller.dart';
import 'package:admin_panel/feature/shop/model/brand_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';

class EditBrandScreen extends StatelessWidget {
  const EditBrandScreen(
      {super.key, required this.isShow, required this.brandModel});

  final bool isShow;
  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
        appBar: const MAppBar(
          title: Text("Edit Brand..."),
          showBackArrow: true,
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(MSizes.spaceBtwItems),
              child: Column(
                children: [
                  const MSectionHeading(
                    title: 'Image of Brand ',
                    showActionButton: false,
                  ),

                  Stack(
                    children: [
                      CachedNetworkImage(
                          imageUrl: brandModel.image,
                          fit: BoxFit.contain,
                          height: Get.height / 5.5,
                          width: Get.width / 2,
                          placeholder: (context, url) => const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error)),
                      Positioned(
                          right: 10,
                          top: 0,
                          child: InkWell(
                            onTap: () async {
                              await controller
                                  .deleteImageFromStorage(brandModel.image);
                              await controller.deleteImageFromFireStore(
                                  brandModel.image, brandModel.id);
                            },
                            child: const CircleAvatar(
                              backgroundColor: MColors.error,
                              child: Icon(
                                Icons.close,
                                color: MColors.white,
                              ),
                            ),
                          ))
                    ],
                  ),

                  const MSectionHeading(
                    title: "Select Brand Image",
                    showActionButton: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Select Brand Image",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                          height: 52,
                          width: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: ElevatedButton(
                              onPressed: () {
                                controller.showImagePickerDialog();
                                controller.isSelect.value = true;
                              },
                              child: const Text("Select Images"))),
                    ],
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwItems,
                  ),

                  //Add Brand image

                  GetBuilder<BrandController>(
                      init: BrandController(),
                      builder: (brandController) {
                        return brandController.selectImage.value != ''
                            ? Container(
                                height: Get.height / 3.7,
                                width: MediaQuery.of(context).size.width - 20,
                                child: Stack(
                                  children: [
                                    Image.file(
                                      File(brandController
                                          .selectImage.value.path),
                                      fit: BoxFit.cover,
                                      height: Get.height / 4,
                                      width: Get.width / 2,
                                    ),
                                  ],
                                ),
                              )
                            : Text('mmmmm');
                      }),

                  Form(
                    key: controller.brandFormKey,
                    child: Column(
                      children: [
                        const MSectionHeading(
                          title: "Brand Name",
                          showActionButton: false,
                        ),
                        TextFormField(
                          controller: controller.brandName
                            ..text = brandModel.name,
                          validator: (value) =>
                              MValidator.validateEmptyText("Brand_Name", value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: MTexts.brandName,
                              prefixIcon: Icon(Iconsax.user)),
                        ),
                        const SizedBox(
                          height: MSizes.spaceBtwItems,
                        ),
                        const MSectionHeading(
                          title: "Brand Id",
                          showActionButton: false,
                        ),
                        TextFormField(
                          controller: controller.brandId..text = brandModel.id,
                          validator: (value) =>
                              MValidator.validateEmptyText("brand_Id", value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: MTexts.brandId,
                              prefixIcon: Icon(Iconsax.dcube)),
                        ),
                        const SizedBox(
                          height: MSizes.spaceBtwItems,
                        ),
                        const MSectionHeading(
                          title: "Product Stock of Brand",
                          showActionButton: false,
                        ),
                        TextFormField(
                          controller: controller.productCount
                            ..text = brandModel.productsCount.toString(),
                          validator: (value) => MValidator.validateEmptyText(
                              "Product_count", value),
                          expands: false,
                          decoration: const InputDecoration(
                              labelText: MTexts.productCount,
                              prefixIcon: Icon(Iconsax.dcube)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: MSizes.spaceBtwItems,
                  ),
                  GetBuilder<BrandController>(
                      init: BrandController(),
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

                  isShow == true
                      ? SizedBox(
                          width: double.infinity,
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator.adaptive()
                              : ElevatedButton(
                                  onPressed: () async {
                                    await controller.uploadBrand();
                                  },
                                  child: const Text("Upload Edit Brand")))
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ));
  }
}
