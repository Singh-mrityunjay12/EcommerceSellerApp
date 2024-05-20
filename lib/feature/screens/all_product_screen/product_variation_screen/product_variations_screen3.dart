import 'dart:io';

import 'package:admin_panel/feature/shop/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../shop/controllers/product_variation/product_variation_controller3.dart';

// ignore: must_be_immutable
class ProductVariationsScreen3 extends StatelessWidget {
  const ProductVariationsScreen3(
      {super.key, required this.productNumber, this.productModel});

  final String productNumber;
  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductVariationsController3());
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
            controller: controller.variationsId3
              ..text = productModel!.productVariations![2].id != ''
                  ? productModel!.productVariations![2].id
                  : '',
            validator: (value) =>
                MValidator.validateEmptyText("Variations_Id3", value),
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
            controller: controller.variationsStock3
              ..text =
                  productModel!.productVariations![2].stock.toString() != ''
                      ? productModel!.productVariations![2].stock.toString()
                      : '',
            validator: (value) =>
                MValidator.validateEmptyText("Variations_stock3", value),
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
            controller: controller.variationsPrice3
              ..text =
                  productModel!.productVariations![2].price.toString() != ''
                      ? productModel!.productVariations![2].price.toString()
                      : '',
            validator: (value) =>
                MValidator.validateEmptyText("Variation_price3", value),
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
            controller: controller.variationsSalePrice3
              ..text =
                  productModel!.productVariations![2].salePrice.toString() != ''
                      ? productModel!.productVariations![2].salePrice.toString()
                      : '',
            validator: (value) =>
                MValidator.validateEmptyText("Variations_sale_price3", value),
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
                        controller.showImagePickerDialog3();
                      },
                      child: const Text("Select Images"))),
            ],
          ),
          const SizedBox(
            height: MSizes.spaceBtwItems,
          ),

          //Add Category image

          GetBuilder<ProductVariationsController3>(
              init: ProductVariationsController3(),
              builder: (variationController) {
                return variationController.selectImage3 != ''
                    ? Container(
                        height: Get.height / 3.7,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Stack(
                          children: [
                            Image.file(
                              File(variationController.selectImage3.value.path),
                              fit: BoxFit.cover,
                              height: Get.height / 4,
                              width: Get.width / 2,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        child: Image.network(
                          productModel!.productVariations![2].image != ''
                              ? productModel!.productVariations![2].image
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
                controller: controller.variationsColor3
                  ..text = productModel!
                              .productVariations![2].attributeValues['Color']
                              .toString() !=
                          ''
                      ? productModel!
                          .productVariations![2].attributeValues['Color']
                          .toString()
                      : '',
                validator: (value) =>
                    MValidator.validateEmptyText("Variations_color3", value),
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
                controller: controller.variationsSize3
                  ..text = productModel!
                              .productVariations![2].attributeValues['Size']
                              .toString() !=
                          ''
                      ? productModel!
                          .productVariations![2].attributeValues['Size']
                          .toString()
                      : '',
                validator: (value) =>
                    MValidator.validateEmptyText("Variations_size3", value),
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
            controller: controller.variationsDescriptions3
              ..text = productModel!.productVariations![2].description
                          .toString() !=
                      ''
                  ? productModel!.productVariations![2].description.toString()
                  : '',
            validator: (value) =>
                MValidator.validateEmptyText("Variations_description3", value),
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
