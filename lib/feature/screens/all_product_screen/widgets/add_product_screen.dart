import 'dart:io';

import 'package:admin_panel/common/widgets/texts/section_heading.dart';
import 'package:admin_panel/feature/screens/all_product_screen/product_variation_screen/product_variations_screen2.dart';
import 'package:admin_panel/feature/screens/all_product_screen/product_variation_screen/product_variations_screen3.dart';
import 'package:admin_panel/feature/screens/all_product_screen/product_variation_screen/product_variations_screen4.dart';
import 'package:admin_panel/feature/screens/all_product_screen/widgets/dropdown_category_widget.dart';
import 'package:admin_panel/feature/screens/all_product_screen/widgets/product_atribute_screen.dart';

import 'package:admin_panel/feature/shop/controllers/brand_controller.dart';
import 'package:admin_panel/feature/shop/controllers/is_sale_controller.dart';
import 'package:admin_panel/feature/shop/controllers/products/add_product_field_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../shop/controllers/products/add_product_images_controller.dart';
import '../../../shop/model/product_model.dart';
import '../product_variation_screen/product_variations_screen1.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addProductImagesController = Get.put(AddProductsImagesController());
    final addProductField = Get.put(AddFieldProductController());

    final brandController = Get.put(BrandController());
    final isSaleController = IsSaleController.instance;

    return Scaffold(
        appBar: const MAppBar(
          title: Text("Add Products"),
          showBackArrow: true,
        ),
        bottomNavigationBar: Obx(() => SizedBox(
            height: 60,
            // width: double.infinity,
            child: addProductField.isLoading.value
                ? CircularProgressIndicator.adaptive()
                : ElevatedButton(
                    onPressed: () async {
                      await addProductField.uploadProduct();
                    },
                    child: const Text("Upload Product")))),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.all(MSizes.spaceBtwProduct),
            child: Container(
              child: ListView(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Select Product Images",
                        style: TextStyle(fontSize: 18),
                      ),
                      Container(
                          height: 52,
                          width: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: ElevatedButton(
                              onPressed: () {
                                addProductImagesController
                                    .showImagesPickerDialog();
                              },
                              child: const Text("Select Images"))),
                    ],
                  ),
                  const SizedBox(
                    height: MSizes.spaceBtwSection,
                  ),

                  //show Images
                  //It is used to show the images in real time whenever changes in my add_product_images_controller

                  GetBuilder<AddProductsImagesController>(
                      init: AddProductsImagesController(),
                      builder: (imageController) {
                        return imageController.selectImages.isNotEmpty
                            ? SizedBox(
                                height: Get.height / 3.0,
                                width: MediaQuery.of(context).size.width - 20,
                                child: GridView.builder(
                                    itemCount:
                                        imageController.selectImages.length,
                                    physics: const BouncingScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 20,
                                            crossAxisSpacing: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(
                                        children: [
                                          Image.file(
                                            File(imageController
                                                .selectImages[index].path),
                                            fit: BoxFit.cover,
                                            height: Get.height / 4,
                                            width: Get.width / 2,
                                          ),
                                          Positioned(
                                              right: 10,
                                              top: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  //this button used to remove image
                                                  imageController
                                                      .removeImages(index);
                                                },
                                                child: const CircleAvatar(
                                                  backgroundColor:
                                                      MColors.error,
                                                  child: Icon(
                                                    Icons.close,
                                                    color: MColors.white,
                                                  ),
                                                ),
                                              ))
                                        ],
                                      );
                                    }),
                              )
                            : const SizedBox.shrink();
                      }),
                  //show categories drop down
                  const DropDownCategoryWidget(),
                  const SizedBox(
                    height: MSizes.spaceBtwItems,
                  ),

                  //Is sale
                  GetBuilder<IsSaleController>(
                      init: IsSaleController(),
                      builder: (isSaleController) {
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Is_Sale'),
                              ),
                              Switch(
                                  value: isSaleController.isSale.value,
                                  onChanged: (value) {
                                    isSaleController.toggleIsSale(value);
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
                            controller: addProductField.productId,
                            validator: (value) => MValidator.validateEmptyText(
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
                            controller: addProductField.productTitle,
                            maxLines: 3,
                            validator: (value) => MValidator.validateEmptyText(
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
                            controller: addProductField.productStock,
                            validator: (value) => MValidator.validateEmptyText(
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
                            controller: addProductField.productPrice,
                            validator: (value) => MValidator.validateEmptyText(
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
                                  controller: addProductField.productSalePrice,
                                  validator: (value) =>
                                      MValidator.validateEmptyText(
                                          "Product_Sale_Price", value),
                                  expands: false,
                                  decoration: const InputDecoration(
                                      labelText: MTexts.productSalePrice,
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
                            controller: addProductField.productCategoryId,
                            validator: (value) => MValidator.validateEmptyText(
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
                            controller: addProductField.productCategoryId,
                            validator: (value) => MValidator.validateEmptyText(
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
                            controller: brandController.brandName,
                            validator: (value) => MValidator.validateEmptyText(
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
                            controller: brandController.brandId,
                            validator: (value) =>
                                MValidator.validateEmptyText("brand_Id", value),
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
                            controller: brandController.productCount,
                            validator: (value) => MValidator.validateEmptyText(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Select Brand Image",
                                style: TextStyle(fontSize: 18),
                              ),
                              Container(
                                  height: 52,
                                  width: 150,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        brandController.showImagePickerDialog();
                                      },
                                      child: const Text("Select Images"))),
                            ],
                          ),
                          const SizedBox(
                            height: MSizes.spaceBtwInputFields,
                          ),
                          //Add Brand image

                          GetBuilder<BrandController>(
                              init: BrandController(),
                              builder: (brandController) {
                                return brandController.selectImage != ''
                                    ? Container(
                                        height: Get.height / 3.7,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
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
                                    : const SizedBox();
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Is_Feature for Brand',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
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
                          ProductAttributeScreen(
                            productModel: ProductModel.empty(),
                            check: false,
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Is_Active for Variations',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Switch(
                                          value: controller.isActive.value,
                                          onChanged: (value) {
                                            controller.toggleIsFeature1(value);
                                            print(value);
                                          })
                                    ],
                                  ),
                                );
                              }),
                          addProductField.isActive.value
                              ? Container(
                                  child: Column(
                                    children: [
                                      const MSectionHeading(
                                        title: "Product Variations Details",
                                        showActionButton: false,
                                      ),
                                      ProductVariationsScreen1(
                                        productNumber: '1',
                                        productModel: ProductModel.empty(),
                                        check: false,
                                      ),
                                      // ProductVariationsScreen2(
                                      //   productNumber: '2',
                                      //   productModel: ProductModel.empty(),
                                      // ),
                                      // ProductVariationsScreen3(
                                      //   productNumber: '3',
                                      //   productModel: ProductModel.empty(),
                                      // ),
                                      // ProductVariationsScreen4(
                                      //   productNumber: '4',
                                      //   productModel: ProductModel.empty(),
                                      // ),
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
                            controller: addProductField.productType,
                            validator: (value) => MValidator.validateEmptyText(
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Is_Feature for Product',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Switch(
                                          value: controller.isFeatured.value,
                                          onChanged: (value) {
                                            controller.toggleIsFeature(value);
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
        ));
  }
}
