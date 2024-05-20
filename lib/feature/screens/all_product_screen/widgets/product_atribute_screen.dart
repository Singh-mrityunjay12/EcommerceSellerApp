import 'package:admin_panel/feature/shop/controllers/products/product_attribute_controller.dart';
import 'package:admin_panel/feature/shop/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';

class ProductAttributeScreen extends StatelessWidget {
  const ProductAttributeScreen(
      {super.key, required this.productModel, required this.check});

  final ProductModel productModel;
  final bool check;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductAttributeController());
    return SingleChildScrollView(
      child: Column(
        children: [
          const MSectionHeading(
            title: "Product Attribute Details",
            showActionButton: false,
          ),
          const MSectionHeading(
            title: "Product Colors",
            showActionButton: false,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextFormField(
                  controller: check
                      ? (controller.color1
                        ..text = productModel.productAttributes![0].values![0])
                      : controller.color1,
                  validator: (value) =>
                      MValidator.validateEmptyText("Color1", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: MTexts.color1,
                      prefixIcon: Icon(Iconsax.color_swatch)),
                ),
              ),
              const SizedBox(
                width: MSizes.sMin,
              ),
              Expanded(
                child: TextFormField(
                  controller: check
                      ? (controller.color2
                        ..text = productModel.productAttributes![0].values![1])
                      : controller.color2,
                  validator: (value) =>
                      MValidator.validateEmptyText("Color2", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: MTexts.color2,
                      prefixIcon: Icon(Iconsax.color_swatch)),
                ),
              ),
              const SizedBox(
                width: MSizes.sMin,
              ),
              Expanded(
                child: TextFormField(
                  controller: check
                      ? (controller.color3
                        ..text = productModel.productAttributes![0].values![2])
                      : controller.color3,
                  validator: (value) =>
                      MValidator.validateEmptyText("Color3", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: MTexts.color3,
                      prefixIcon: Icon(Iconsax.color_swatch)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: MSizes.spaceBtwInputFields,
          ),
          const MSectionHeading(
            title: "Product Sizes",
            showActionButton: false,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: check
                      ? (controller.size1
                        ..text =
                            productModel.productAttributes![1].values![0] != ''
                                ? productModel.productAttributes![1].values![0]
                                : '')
                      : controller.size1,
                  validator: (value) =>
                      MValidator.validateEmptyText("Size1", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: MTexts.size1, prefixIcon: Icon(Iconsax.size5)),
                ),
              ),
              const SizedBox(
                width: MSizes.sMin,
              ),
              Expanded(
                child: TextFormField(
                  controller: check
                      ? (controller.size2
                        ..text = productModel.productAttributes![1].values![1])
                      : controller.size2,
                  validator: (value) =>
                      MValidator.validateEmptyText("Size2", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: MTexts.size2, prefixIcon: Icon(Iconsax.size5)),
                ),
              ),
              const SizedBox(
                width: MSizes.sMin,
              ),
              Expanded(
                child: TextFormField(
                  controller: check
                      ? (controller.size3
                        ..text = productModel.productAttributes![1].values![2])
                      : controller.size3,
                  validator: (value) =>
                      MValidator.validateEmptyText("Size3", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: MTexts.size3, prefixIcon: Icon(Iconsax.size5)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
