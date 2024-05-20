import 'package:admin_panel/feature/screens/notification/notification_screen.dart';

import 'package:admin_panel/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../feature/screens/address/address_screen.dart';
import '../../feature/screens/orders/widgets/check_single_order_screen.dart';
import '../../feature/shop/controllers/products/cancelled_controller.dart';
import '../../feature/shop/controllers/products/delivered_controller.dart';
import '../../feature/shop/controllers/products/pending_controller.dart';
import '../../feature/shop/controllers/products/processing_controller.dart';
import '../../feature/shop/controllers/products/shipped_controller.dart';
import '../../feature/shop/model/order_model.dart';
import 'sizes.dart';

class BottomSheetModel extends GetxController {
  //Variable
  final processingController = Get.put(ProcessingController());
  final shippedController = Get.put(ShippedController());
  final pendingController = Get.put(PendingController());
  final deliveredController = Get.put(DeliveredController());
  final cancelledController = Get.put(CancelledController());
  // final notificationController = Get.put(NotificationController());
  void showBottomSheet(OrderModel order, String email, String token) {
    Get.bottomSheet(SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
              color: MColors.white, borderRadius: BorderRadius.circular(20.0)),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    processingController.isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    processingController.updateField(
                                        "OrderStatus.processing",
                                        order.uuid,
                                        order.userId);
                                  },
                                  child: const Text("Processing")),
                            ),
                          ),
                    shippedController.isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    shippedController.updateField(
                                        "OrderStatus.shipped",
                                        order.uuid,
                                        order.userId);
                                  },
                                  child: const Text("Shipped")),
                            ),
                          )
                  ],
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    pendingController.isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    pendingController.updateField(
                                        "OrderStatus.pending",
                                        order.uuid,
                                        order.userId);
                                  },
                                  child: const Text("Pending")),
                            ),
                          ),
                    deliveredController.isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    deliveredController.updateField(
                                        "OrderStatus.delivered",
                                        order.uuid,
                                        order.userId);
                                  },
                                  child: const Text("Delivered")),
                            ),
                          )
                  ],
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelledController.isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    cancelledController.updateField(
                                        "OrderStatus.cancelled",
                                        order.uuid,
                                        order.userId);
                                  },
                                  child: const Text("Cancelled")),
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => CheckSingleOrderScreen(
                                    cartItemModel: order.items.first,
                                    orderModel: order,
                                  ));
                            },
                            child: const Text("Ordered Item by User")),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => NotificationScreen(token: token));
                            },
                            child: const Text("Send notification to User")),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: MSizes.spaceBtwItems / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => AddressScreen(
                                    orderModel: order,
                                    email: email,
                                  ));
                            },
                            child: const Text("Address of the User")),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    ));
  }
}
