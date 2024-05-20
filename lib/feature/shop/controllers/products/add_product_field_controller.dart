import 'package:admin_panel/common/widgets/loadders/loadders.dart';
import 'package:admin_panel/feature/shop/controllers/brand_controller.dart';
import 'package:admin_panel/feature/shop/controllers/is_sale_controller.dart';
import 'package:admin_panel/feature/shop/controllers/product_variation/product_variation_controller2.dart';
import 'package:admin_panel/feature/shop/controllers/product_variation/product_variation_controller3.dart';
import 'package:admin_panel/feature/shop/controllers/product_variation/product_variation_controller4.dart';
import 'package:admin_panel/feature/shop/controllers/product_variation/product_variations_controller1.dart';
import 'package:admin_panel/feature/shop/controllers/products/add_product_images_controller.dart';

import 'package:admin_panel/feature/shop/controllers/products/product_attribute_controller.dart';

import 'package:admin_panel/feature/shop/model/brand_model.dart';
import 'package:admin_panel/feature/shop/model/product_attribute_model.dart';
import 'package:admin_panel/feature/shop/model/product_model.dart';
import 'package:admin_panel/feature/shop/model/product_variation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/Network/network_manager.dart';

import '../../../../utils/exception/firebase_auth_exception.dart';
import '../../../../utils/exception/formate_exceptions.dart';
import '../../../../utils/exception/platform_exceptions.dart';

class AddFieldProductController extends GetxController {
  static AddFieldProductController get instance => Get.find();

  final productVariationsController1 = ProductVariationsController1.instance;
  final productVariationsController2 = ProductVariationsController2.instance;
  final productVariationsController3 = ProductVariationsController3.instance;
  final productVariationsController4 = ProductVariationsController4.instance;
  final productAttributeController = ProductAttributeController.instance;
  final addProductsImagesController = AddProductsImagesController.instance;
  final isSaleController = IsSaleController();
  final brandController = BrandController.instance;
  final _db = FirebaseFirestore.instance;
  final productId = TextEditingController();
  final productTitle = TextEditingController();
  final productStock = TextEditingController();
  final productPrice = TextEditingController();
  final productSalePrice = TextEditingController();

  final productDescriptions = TextEditingController();
  final productSkuId = TextEditingController();
  final productCategoryId = TextEditingController();
  final productType = TextEditingController();

  //Form key
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();

  final isFeatured = false.obs;
  final isActive = false.obs;
  final isLoading = false.obs;

  void toggleIsFeature(bool value) {
    isFeatured.value = value;
    print("//////////////////////////$isFeatured");
    update();
  }

  void toggleIsFeature1(bool value) {
    isActive.value = value;
    print("////////////////////////////$isActive");
    update();
  }

  //Upload Product
  Future<void> uploadProduct() async {
    try {
      //Start Loading
      isLoading.value = true;
      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //isConnected is false means no Internet then stop the loading
        return;
      }
      //Form Validation
      if (!productFormKey.currentState!.validate()) {
        // MFullScreenLoader.stopLoading();
        return;
      }
      print("////////////////////////////////////////////AAAAAAAAAAAAAA");
      //Upload Product Images  and Get's its Url

      await addProductsImagesController
          .uploadProductFunction(addProductsImagesController.selectImages);

      //Upload Brand Images  and Get's its Url
      await brandController
          .uploadBrandFunction(brandController.selectImage.value);
      print("////////////////////////////////////////////BBBBBBBBBBB");
      //Upload Variations Images  and Get's its Url
      await productVariationsController1.uploadVariationFunction1(
          productVariationsController1.selectImage1.value);
      await productVariationsController2.uploadVariationFunction2(
          productVariationsController2.selectImage2.value);
      await productVariationsController3.uploadVariationFunction3(
          productVariationsController3.selectImage3.value);
      await productVariationsController4.uploadVariationFunction4(
          productVariationsController4.selectImage4.value);
      print("////////////////////////////////////////////CCCCCCCCCCC");

      ProductModel productModel = ProductModel(
          id: productId.text.trim(),
          title: productTitle.text.trim(),
          stock: int.parse(productStock.text.trim()),
          price: double.parse(productPrice.text.trim()),
          thumbnail: addProductsImagesController.arrImagesUrl[0].toString(),
          brand: BrandModel(
              id: brandController.brandId.text.trim(),
              name: brandController.brandName.text.trim(),
              image: brandController.imageUrl1.value.toString(),
              isFeatured: brandController.isFeature.value,
              productsCount:
                  int.parse(brandController.productCount.text.trim())),
          images: addProductsImagesController.arrImagesUrl,
          salePrice: double.parse(productSalePrice.text.trim()),
          sku: productSkuId.text.trim(),
          categoryId: productCategoryId.text.trim(),
          isFeatured: isSaleController.isSale.value,
          productAttributes: [
            ProductAttributeModel(
              name: 'Color',
              values: [
                productAttributeController.color1.text.trim(),
                productAttributeController.color2.text.trim(),
                productAttributeController.color3.text.trim()
              ],
            ),
            ProductAttributeModel(
              name: 'Size',
              values: [
                productAttributeController.size1.text.trim(),
                productAttributeController.size2.text.trim(),
                productAttributeController.size3.text.trim()
              ],
            )
          ],
          productVariations: [
            ProductVariationModel(
                id: productVariationsController1.variationsId1.text.trim(),
                stock: int.parse(
                    productVariationsController1.variationsStock1.text.trim()),
                price: double.parse(
                    productVariationsController1.variationsPrice1.text.trim()),
                salePrice: double.parse(productVariationsController1
                    .variationsSalePrice1.text
                    .trim()),
                image: productVariationsController1.imageUrl1.value.toString(),
                description: productVariationsController1
                    .variationsDescriptions1.text
                    .trim(),
                attributeValues: {
                  'Color':
                      productVariationsController1.variationsColor1.text.trim(),
                  'Size':
                      productVariationsController1.variationsSize1.text.trim()
                }),
            ProductVariationModel(
                id: productVariationsController2.variationsId2.text.trim(),
                stock: int.parse(
                    productVariationsController2.variationsStock2.text.trim()),
                price: double.parse(
                    productVariationsController2.variationsPrice2.text.trim()),
                salePrice: double.parse(productVariationsController2
                    .variationsSalePrice2.text
                    .trim()),
                image: productVariationsController2.imageUrl2.value.toString(),
                description: productVariationsController2
                    .variationsDescriptions2.text
                    .trim(),
                attributeValues: {
                  'Color':
                      productVariationsController2.variationsColor2.text.trim(),
                  'Size':
                      productVariationsController2.variationsSize2.text.trim()
                }),
            ProductVariationModel(
                id: productVariationsController3.variationsId3.text.trim(),
                stock: int.parse(
                    productVariationsController3.variationsStock3.text.trim()),
                price: double.parse(
                    productVariationsController3.variationsPrice3.text.trim()),
                salePrice: double.parse(productVariationsController3
                    .variationsSalePrice3.text
                    .trim()),
                image: productVariationsController3.imageUrl3.value.toString(),
                description: productVariationsController3
                    .variationsDescriptions3.text
                    .trim(),
                attributeValues: {
                  'Color':
                      productVariationsController3.variationsColor3.text.trim(),
                  'Size':
                      productVariationsController3.variationsSize3.text.trim()
                }),
            ProductVariationModel(
                id: productVariationsController4.variationsId4.text.trim(),
                stock: int.parse(
                    productVariationsController4.variationsStock4.text.trim()),
                price: double.parse(
                    productVariationsController4.variationsPrice4.text.trim()),
                salePrice: double.parse(productVariationsController4
                    .variationsSalePrice4.text
                    .trim()),
                image: productVariationsController4.imageUrl4.value.toString(),
                description: productVariationsController4
                    .variationsDescriptions4.text
                    .trim(),
                attributeValues: {
                  'Color':
                      productVariationsController4.variationsColor4.text.trim(),
                  'Size':
                      productVariationsController4.variationsSize4.text.trim()
                })
          ],
          productType: productType.text.trim());

      print("////////////////////////////////////////////EEEEEEEEEEE");

      //Store Product in Firebase
      await _db
          .collection("Products")
          .doc(productModel.id)
          .set(productModel.toJson());

      print("////////////////////////////////////////////FFFFFFFFFF");

      MLoader.successSnackBar(
          title: "Congratulation",
          message: "Your Product has been successFully uploaded!");

      isLoading.value = false;
    } on FirebaseException catch (e) {
      throw MFirebaseAuthException(e.code).message;
    } on FormatException catch (_) {
      throw const MFormatException();
    } on PlatformException catch (e) {
      throw MPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong .Please try again';
    }
  }
}
