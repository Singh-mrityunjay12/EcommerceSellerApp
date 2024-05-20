import 'dart:io';

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
import '../../../shop/controllers/product_variation/product_variations_controller1.dart';

// ignore: must_be_immutable
class ProductVariationsScreen1 extends StatelessWidget {
  const ProductVariationsScreen1({
    required this.productNumber,
    required this.productModel,
    required this.check,
    super.key,
  });
  final String productNumber;
  final ProductModel productModel;
  final bool check;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductVariationsController1());
    final variation = productModel.productVariations?[0];
    return SingleChildScrollView(
      child: Column(
        children: [
          MSectionHeading(
            title: "Product ${productNumber}",
            showActionButton: false,
          ),
          const MSectionHeading(
            title: "Product Variation id ",
            showActionButton: false,
          ),

          TextFormField(
            controller: check
                ? (controller.variationsId1
                  ..text = variation?.id != '' ? variation!.id : '')
                : controller.variationsId1,
            validator: (value) =>
                MValidator.validateEmptyText("Variations_Id", value),
            expands: false,
            decoration: const InputDecoration(
                labelText: MTexts.variationId,
                prefixIcon: Icon(Iconsax.tag_user)),
          ),

          const MSectionHeading(
            title: "Product Variation of stock ",
            showActionButton: false,
          ),

          TextFormField(
            controller: check
                ? (controller.variationsStock1
                  ..text = productModel.productVariations![0].stock != 0
                      ? productModel.productVariations![0].stock.toString()
                      : '')
                : controller.variationsStock1,
            validator: (value) =>
                MValidator.validateEmptyText("Variations_stock", value),
            expands: false,
            decoration: const InputDecoration(
                labelText: MTexts.variationStock,
                prefixIcon: Icon(Iconsax.shop_add)),
          ),
          const MSectionHeading(
            title: "Product Variation of price",
            showActionButton: false,
          ),
          TextFormField(
            controller: check
                ? (controller.variationsPrice1
                  ..text = productModel.productVariations![0].price != 0.0
                      ? productModel.productVariations![0].price.toString()
                      : '')
                : controller.variationsPrice1,
            validator: (value) =>
                MValidator.validateEmptyText("Variation_price", value),
            expands: false,
            decoration: const InputDecoration(
                labelText: MTexts.variationSalePrice,
                prefixIcon: Icon(Iconsax.money)),
          ),
          const MSectionHeading(
            title: "Product Variation of sale price",
            showActionButton: false,
          ),
          TextFormField(
            controller: check
                ? (controller.variationsSalePrice1
                  ..text = productModel.productVariations![0].salePrice != 0.0
                      ? productModel.productVariations![0].salePrice.toString()
                      : '')
                : controller.variationsSalePrice1,
            validator: (value) =>
                MValidator.validateEmptyText("Variations_sale_price", value),
            expands: false,
            decoration: const InputDecoration(
                labelText: MTexts.variationSalePrice,
                prefixIcon: Icon(Iconsax.money)),
          ),
          const MSectionHeading(
            title: "Select Image",
            showActionButton: false,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Select Product Image",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                  height: 52,
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                      onPressed: () {
                        controller.showImagePickerDialog1();
                      },
                      child: const Text("Select Images"))),
            ],
          ),
          const SizedBox(
            height: MSizes.spaceBtwItems,
          ),

          //Add Category image

          GetBuilder<ProductVariationsController1>(
              init: ProductVariationsController1(),
              builder: (variationController) {
                return variationController.selectImage1.value != ''
                    ? Container(
                        height: Get.height / 3.7,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Stack(
                          children: [
                            Image.file(
                              File(variationController.selectImage1.value.path),
                              fit: BoxFit.cover,
                              height: Get.height / 4,
                              width: Get.width / 2,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        child: Image.network(
                          productModel.productVariations![0].image != ''
                              ? productModel.productVariations![0].image
                              : '',
                          fit: BoxFit.cover,
                          height: Get.height / 4,
                          width: Get.width / 2,
                        ),
                      );
              }),

          const MSectionHeading(
            title: "Product Attribute of Product Variations",
            showActionButton: false,
          ),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: check
                    ? (controller.variationsColor1
                      ..text = productModel.productVariations![0]
                                  .attributeValues['Color']
                                  .toString() !=
                              ''
                          ? productModel
                              .productVariations![0].attributeValues['Color']
                              .toString()
                          : '')
                    : controller.variationsColor1,
                validator: (value) =>
                    MValidator.validateEmptyText("Variations_color", value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: MTexts.variationColor,
                    prefixIcon: Icon(Iconsax.color_swatch)),
              )),
              const SizedBox(
                width: MSizes.sMin,
              ),
              Expanded(
                  child: TextFormField(
                controller: check
                    ? (controller.variationsSize1
                      ..text = productModel
                                  .productVariations![0].attributeValues['Size']
                                  .toString() !=
                              ''
                          ? productModel
                              .productVariations![0].attributeValues['Size']
                              .toString()
                          : '')
                    : controller.variationsSize1,
                validator: (value) =>
                    MValidator.validateEmptyText("Variations_size", value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: MTexts.variationSize,
                    prefixIcon: Icon(Iconsax.size5)),
              )),
            ],
          ),

          const MSectionHeading(
            title: "Description.....",
            showActionButton: false,
          ),
          TextFormField(
            maxLines: 5,
            controller: check
                ? (controller.variationsDescriptions1
                  ..text = productModel.productVariations![0].description != ''
                      ? productModel.productVariations![0].description
                          .toString()
                      : '')
                : controller.variationsDescriptions1,
            validator: (value) =>
                MValidator.validateEmptyText("Variations_description", value),
            expands: false,
            decoration: const InputDecoration(
                labelText: MTexts.variationDescription,
                prefixIcon: Icon(Iconsax.text)),
          )
        ],
      ),
    );
  }
}
