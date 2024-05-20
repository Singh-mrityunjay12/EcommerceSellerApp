import 'package:admin_panel/common/widgets/Network/network_manager.dart';
import 'package:admin_panel/feature/authentication/persionalizations/models/firebase_notifications/firebase_notifications.dart';
import 'package:admin_panel/feature/shop/controllers/brand_controller.dart';
import 'package:admin_panel/feature/shop/controllers/is_sale_controller.dart';
import 'package:admin_panel/feature/shop/controllers/product_variation/product_variation_controller2.dart';
import 'package:admin_panel/feature/shop/controllers/product_variation/product_variation_controller3.dart';
import 'package:admin_panel/feature/shop/controllers/product_variation/product_variation_controller4.dart';
import 'package:admin_panel/feature/shop/controllers/product_variation/product_variations_controller1.dart';

import 'package:admin_panel/feature/shop/controllers/products/add_product_images_controller.dart';
import 'package:admin_panel/feature/shop/controllers/products/product_attribute_controller.dart';

import 'package:get/get.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(FirebaseNotificationController());
    Get.put(BrandController());
    Get.put(IsSaleController());
    Get.put(ProductAttributeController());
    Get.put(ProductVariationsController1());
    Get.put(ProductVariationsController2());
    Get.put(ProductVariationsController3());
    Get.put(ProductVariationsController4());
    Get.put(AddProductsImagesController());
  }
}
