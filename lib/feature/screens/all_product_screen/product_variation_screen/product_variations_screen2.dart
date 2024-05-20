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
import '../../../shop/controllers/product_variation/product_variation_controller2.dart';

// ignore: must_be_immutable
class ProductVariationsScreen2 extends StatelessWidget {
  const ProductVariationsScreen2({
    super.key,
    required this.productNumber,
    this.productModel,
  });

  final String productNumber;
  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductVariationsController2());
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
            controller: controller.variationsId2
              ..text = productModel!.productVariations![1].id != ''
                  ? productModel!.productVariations![1].id
                  : '',
            validator: (value) =>
                MValidator.validateEmptyText("Variations_Id2", value),
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
            controller: controller.variationsStock2
              ..text =
                  productModel!.productVariations![1].stock.toString() != ''
                      ? productModel!.productVariations![1].stock.toString()
                      : '',
            validator: (value) =>
                MValidator.validateEmptyText("Variations_stock2", value),
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
            controller: controller.variationsPrice2
              ..text =
                  productModel!.productVariations![1].price.toString() != ''
                      ? productModel!.productVariations![1].price.toString()
                      : '',
            validator: (value) =>
                MValidator.validateEmptyText("Variation_price2", value),
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
            controller: controller.variationsSalePrice2
              ..text =
                  productModel!.productVariations![1].salePrice.toString() != ''
                      ? productModel!.productVariations![1].salePrice.toString()
                      : '',
            validator: (value) =>
                MValidator.validateEmptyText("Variations_sale_price2", value),
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
                        controller.showImagePickerDialog2();
                      },
                      child: const Text("Select Images"))),
            ],
          ),
          const SizedBox(
            height: MSizes.spaceBtwItems,
          ),

          //Add Category image

          GetBuilder<ProductVariationsController2>(
              init: ProductVariationsController2(),
              builder: (variationController) {
                return variationController.selectImage2 != ''
                    ? Container(
                        height: Get.height / 3.7,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Stack(
                          children: [
                            Image.file(
                              File(variationController.selectImage2.value.path),
                              fit: BoxFit.cover,
                              height: Get.height / 4,
                              width: Get.width / 2,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        child: Image.network(
                          productModel!.productVariations![1].image != ''
                              ? productModel!.productVariations![1].image
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
                controller: controller.variationsColor2
                  ..text = productModel!
                              .productVariations![1].attributeValues['Color']
                              .toString() !=
                          ''
                      ? productModel!
                          .productVariations![1].attributeValues['Color']
                          .toString()
                      : '',
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
                controller: controller.variationsSize2
                  ..text = productModel!
                              .productVariations![1].attributeValues['Size']
                              .toString() !=
                          ''
                      ? productModel!
                          .productVariations![1].attributeValues['Size']
                          .toString()
                      : '',
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
            controller: controller.variationsDescriptions2
              ..text = productModel!.productVariations![1].description
                          .toString() !=
                      ''
                  ? productModel!.productVariations![1].description.toString()
                  : '',
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
