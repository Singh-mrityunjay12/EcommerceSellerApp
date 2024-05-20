import 'dart:io';

import 'package:admin_panel/feature/shop/controllers/products/product_edit_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../shop/controllers/brand_controller.dart';
import '../../../shop/controllers/is_sale_controller.dart';
import '../../../shop/controllers/products/add_product_field_controller.dart';
import '../../../shop/model/product_model.dart';

import '../product_variation_screen/product_variations_screen1.dart';
import '../product_variation_screen/product_variations_screen2.dart';
import '../product_variation_screen/product_variations_screen3.dart';
import '../product_variation_screen/product_variations_screen4.dart';
import 'product_atribute_screen.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final addProductField = Get.put(AddFieldProductController());

    final brandController = Get.put(BrandController());
    final isSaleController = IsSaleController.instance;
    return GetBuilder<ProductEditController>(
        init: ProductEditController(productModel: productModel),
        builder: (controller) {
          return Scaffold(
              appBar: MAppBar(
                title: Text("Edit Product ${productModel.id}"),
                showBackArrow: true,
              ),
              body: Obx(
                () => Padding(
                  padding: EdgeInsets.all(MSizes.spaceBtwProduct),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: Get.height / 4.0,
                            width: MediaQuery.of(context).size.width - 20,
                            child: GridView.builder(
                                itemCount: controller.images.length,
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: [
                                      CachedNetworkImage(
                                          imageUrl: controller.images[index],
                                          fit: BoxFit.contain,
                                          height: Get.height / 5.5,
                                          width: Get.width / 2,
                                          placeholder: (context, url) =>
                                              const Center(
                                                child:
                                                    CupertinoActivityIndicator(),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error)),
                                      Positioned(
                                          right: 10,
                                          top: 0,
                                          child: InkWell(
                                            onTap: () async {
                                              await controller
                                                  .deleteImageFromStorage(
                                                      controller.images[index]
                                                          .toString());
                                              await controller
                                                  .deleteImageFromFireStore(
                                                      controller.images[index]
                                                          .toString(),
                                                      productModel.id);
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
                                  );
                                }),
                          ),
                          GetBuilder<IsSaleController>(
                              init: IsSaleController(),
                              builder: (isSaleController) {
                                return Card(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Is_Sale'),
                                      ),
                                      Switch(
                                          value: isSaleController.isSale.value,
                                          onChanged: (value) {
                                            isSaleController
                                                .toggleIsSale(value);
                                            print(value);
                                          })
                                    ],
                                  ),
                                );
                              }),
                          const SizedBox(
                            height: MSizes.spaceBtwItems,
                          ),
                          Form(
                              key: addProductField.productFormKey,
                              child: Column(
                                children: [
                                  const MSectionHeading(
                                    title: "Product Id",
                                    showActionButton: false,
                                  ),
                                  TextFormField(
                                    controller: addProductField.productId
                                      ..text = productModel.id,
                                    validator: (value) =>
                                        MValidator.validateEmptyText(
                                            "Product_Id", value),
                                    expands: false,
                                    decoration: const InputDecoration(
                                        labelText: MTexts.productId,
                                        prefixIcon: Icon(Iconsax.tag_user)),
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "Product Title",
                                    showActionButton: false,
                                  ),
                                  TextFormField(
                                    controller: addProductField.productTitle
                                      ..text = productModel.title,
                                    maxLines: 3,
                                    validator: (value) =>
                                        MValidator.validateEmptyText(
                                            "Product_Title", value),
                                    expands: false,
                                    decoration: const InputDecoration(
                                        labelText: MTexts.productTitle,
                                        prefixIcon: Icon(Iconsax.text)),
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "ProductStock",
                                    showActionButton: false,
                                  ),
                                  TextFormField(
                                    controller: addProductField.productStock
                                      ..text = productModel.stock.toString(),
                                    validator: (value) =>
                                        MValidator.validateEmptyText(
                                            "Product_Stock", value),
                                    expands: false,
                                    decoration: const InputDecoration(
                                        labelText: MTexts.productStock,
                                        prefixIcon: Icon(Iconsax.user)),
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "Product Price",
                                    showActionButton: false,
                                  ),
                                  TextFormField(
                                    controller: addProductField.productPrice
                                      ..text = productModel.price.toString(),
                                    validator: (value) =>
                                        MValidator.validateEmptyText(
                                            "Product_Price", value),
                                    expands: false,
                                    decoration: const InputDecoration(
                                        labelText: MTexts.productPrice,
                                        prefixIcon: Icon(Iconsax.money)),
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "Product Sale Price",
                                    showActionButton: false,
                                  ),
                                  isSaleController.isSale.value
                                      ? TextFormField(
                                          controller:
                                              addProductField.productSalePrice
                                                ..text = productModel.salePrice
                                                    .toString(),
                                          validator: (value) =>
                                              MValidator.validateEmptyText(
                                                  "Product_Sale_Price", value),
                                          expands: false,
                                          decoration: const InputDecoration(
                                              labelText:
                                                  MTexts.productSalePrice,
                                              prefixIcon: Icon(Iconsax.money)),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "Product Category Id",
                                    showActionButton: false,
                                  ),
                                  TextFormField(
                                    controller:
                                        addProductField.productCategoryId
                                          ..text = productModel.categoryId!,
                                    validator: (value) =>
                                        MValidator.validateEmptyText(
                                            "Product_category_id", value),
                                    expands: false,
                                    decoration: const InputDecoration(
                                        labelText: MTexts.productCategoryId,
                                        prefixIcon: Icon(Iconsax.tag)),
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "Product Description",
                                    showActionButton: false,
                                  ),
                                  TextFormField(
                                    maxLines: 5,
                                    controller:
                                        addProductField.productDescriptions
                                          ..text = productModel.description!,
                                    validator: (value) =>
                                        MValidator.validateEmptyText(
                                            "Product_Description", value),
                                    expands: false,
                                    decoration: const InputDecoration(
                                        labelText: MTexts.productDescription,
                                        prefixIcon: Icon(Iconsax.text)),
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "Brand Name",
                                    showActionButton: false,
                                  ),
                                  TextFormField(
                                    controller: brandController.brandName
                                      ..text = productModel.brand!.name,
                                    validator: (value) =>
                                        MValidator.validateEmptyText(
                                            "Brand_Name", value),
                                    expands: false,
                                    decoration: const InputDecoration(
                                        labelText: MTexts.brandName,
                                        prefixIcon: Icon(Iconsax.user)),
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "Brand Id",
                                    showActionButton: false,
                                  ),
                                  TextFormField(
                                    controller: brandController.brandId
                                      ..text = productModel.brand!.id,
                                    validator: (value) =>
                                        MValidator.validateEmptyText(
                                            "brand_Id", value),
                                    expands: false,
                                    decoration: const InputDecoration(
                                        labelText: MTexts.brandId,
                                        prefixIcon: Icon(Iconsax.tag)),
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "Product Stock of Brand",
                                    showActionButton: false,
                                  ),
                                  TextFormField(
                                    controller: brandController.productCount
                                      ..text = productModel.brand!.productsCount
                                          .toString(),
                                    validator: (value) =>
                                        MValidator.validateEmptyText(
                                            "Product_count", value),
                                    expands: false,
                                    decoration: const InputDecoration(
                                        labelText: MTexts.productCount,
                                        prefixIcon: Icon(Iconsax.dcube)),
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "Select Brand Image",
                                    showActionButton: false,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Select Brand Image",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Container(
                                          height: 52,
                                          width: 150,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                brandController
                                                    .showImagePickerDialog();
                                              },
                                              child:
                                                  const Text("Select Images"))),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  //Add Brand image

                                  GetBuilder<BrandController>(
                                      init: BrandController(),
                                      builder: (brandController) {
                                        return brandController
                                                    .selectImage.value !=
                                                ''
                                            ? Container(
                                                height: Get.height / 3.7,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    20,
                                                child: Stack(
                                                  children: [
                                                    Image.file(
                                                      File(brandController
                                                          .selectImage
                                                          .value
                                                          .path),
                                                      fit: BoxFit.cover,
                                                      height: Get.height / 4,
                                                      width: Get.width / 2,
                                                    )
                                                  ],
                                                ),
                                              )
                                            : SizedBox(
                                                child: Image.network(
                                                  productModel.brand!.image,
                                                  fit: BoxFit.cover,
                                                  height: Get.height / 4,
                                                  width: Get.width / 2,
                                                ),
                                              );
                                      }),

                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),
                                  const MSectionHeading(
                                    title: "Is Feature for Brand",
                                    showActionButton: false,
                                  ),
                                  GetBuilder<BrandController>(
                                      init: BrandController(),
                                      builder: (controller) {
                                        return Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Is_Feature for Brand',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Switch(
                                                  value:
                                                      controller.isFeature.value
                                                          ? controller
                                                              .isFeature.value
                                                          : productModel.brand!
                                                              .isFeatured!,
                                                  onChanged: (value) {
                                                    controller
                                                        .toggleIsFeature(value);
                                                    print(value);
                                                  }),
                                            ],
                                          ),
                                        );
                                      }),
                                  ProductAttributeScreen(
                                    productModel: productModel,
                                    check: true,
                                  ),
                                  const MSectionHeading(
                                    title: "Is_Feature for Product Variations",
                                    showActionButton: false,
                                  ),
                                  GetBuilder<AddFieldProductController>(
                                      init: AddFieldProductController(),
                                      builder: (controller) {
                                        return Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Is_Active for Variations',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Switch(
                                                  value:
                                                      controller.isActive.value,
                                                  onChanged: (value) {
                                                    controller.toggleIsFeature1(
                                                        value);
                                                    print(value);
                                                  })
                                            ],
                                          ),
                                        );
                                      }),
                                  addProductField.isActive.value
                                      // ignore: avoid_unnecessary_containers
                                      ? Container(
                                          child: Column(
                                            children: [
                                              const MSectionHeading(
                                                title:
                                                    "Product Variations Details",
                                                showActionButton: false,
                                              ),
                                              ProductVariationsScreen1(
                                                productNumber: '1',
                                                productModel: productModel,
                                                check: true,
                                              ),
                                              ProductVariationsScreen2(
                                                productNumber: '2',
                                                productModel: productModel,
                                              ),
                                              ProductVariationsScreen3(
                                                productNumber: '3',
                                                productModel: productModel,
                                              ),
                                              ProductVariationsScreen4(
                                                productNumber: '4',
                                                productModel: productModel,
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: MSizes.spaceBtwInputFields,
                                  ),

                                  const MSectionHeading(
                                    title: "Product Type of Product",
                                    showActionButton: false,
                                  ),
                                  TextFormField(
                                    controller: addProductField.productType
                                      ..text = productModel.productType,
                                    validator: (value) =>
                                        MValidator.validateEmptyText(
                                            "Product_Type", value),
                                    expands: false,
                                    decoration: const InputDecoration(
                                        labelText: MTexts.productType,
                                        prefixIcon: Icon(Iconsax.sort)),
                                  ),

                                  const MSectionHeading(
                                    title: "Is Feature for Product",
                                    showActionButton: false,
                                  ),
                                  GetBuilder<AddFieldProductController>(
                                      init: AddFieldProductController(),
                                      builder: (controller) {
                                        return Card(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Is_Feature for Product',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Switch(
                                                  value: controller
                                                          .isFeatured.value
                                                      ? controller
                                                          .isFeatured.value
                                                      : productModel
                                                          .isFeatured!,
                                                  onChanged: (value) {
                                                    controller
                                                        .toggleIsFeature(value);
                                                    print(value);
                                                  })
                                            ],
                                          ),
                                        );
                                      }),
                                ],
                              )),
                          const SizedBox(
                            height: MSizes.spaceBtwInputFields,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
