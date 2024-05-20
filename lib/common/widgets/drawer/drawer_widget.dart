import 'package:admin_panel/feature/screens/banner_screens.dart/banner_screen.dart';
import 'package:admin_panel/feature/screens/brand_screens/brand_screen.dart';
import 'package:admin_panel/feature/screens/category_screen/category_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../feature/authentication/persionalizations/controllers/user_controller.dart';
import '../../../feature/screens/all_product_screen/all_product_screen.dart';
import '../../../feature/screens/orders/all_orders_screen.dart';
import '../../../feature/screens/users/user_screen.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text_strings.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final controller = Get.put(UserController());
    // final controller1 = Get.put(OrderController());

    return Scaffold(
      body: Container(
        child: Drawer(
            surfaceTintColor: Colors.white,
            backgroundColor: MColors.purpleColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            )),
            child: Obx(() => SafeArea(
                  child: Wrap(runSpacing: 10, children: [
                    user != null
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Text(
                                MTexts.userName,
                                style: TextStyle(color: MColors.black),
                              ),
                              subtitle: Text(
                                MTexts.appversion,
                                style: TextStyle(color: Colors.grey),
                              ),
                              leading: CircleAvatar(
                                radius: 22.0,
                                backgroundColor: MColors.black,
                                child: Text(
                                  'aa',
                                  style: TextStyle(color: MColors.black),
                                ),
                              ),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              title: Text(
                                "Guest",
                                style: TextStyle(
                                    color: MColors.white, fontSize: 20),
                              ),
                              subtitle: Text(
                                MTexts.appversion,
                                style: TextStyle(color: Colors.grey),
                              ),
                              leading: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: MColors.white,
                                child: Text(
                                  "G",
                                  style: TextStyle(
                                      color: MColors.black, fontSize: 30),
                                ),
                              ),
                            ),
                          ),
                    const Divider(
                      indent: 10.0,
                      endIndent: 10.0,
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: () {
                          // Get.offAll(() => MainScreen());
                        },
                        title: const Text(
                          'Home',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: const Icon(
                          Iconsax.home,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator()
                            : ListTile(
                                onTap: () {
                                  Get.to(() => const UserScreen());
                                },
                                title: const Text(
                                  'Users',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                                leading: const Icon(
                                  Iconsax.profile_circle,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child:
                          //  controller1.isloading.value
                          //     ?
                          //  const CircularProgressIndicator()
                          ListTile(
                        onTap: () {
                          Get.to(() => const AllOrdersScreen());
                        },
                        title: const Text(
                          'Orders',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: const Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        onTap: () {
                          // Get.back();
                          Get.to(() => const AllProductsScreen());
                        },
                        title: const Text(
                          'Products',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        leading: const Icon(
                          Icons.production_quantity_limits,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        onTap: () async {
                          // EasyLoading.show(status: "Please wait");

                          Get.to(() => const CategoryScreen());

                          // EasyLoading.dismiss();
                        },
                        title: const Text(
                          'Categories',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        leading: const Icon(
                          Icons.category,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        onTap: () async {
                          // EasyLoading.show(status: "Please wait");

                          Get.to(() => const BrandScreen());

                          // EasyLoading.dismiss();
                        },
                        title: const Text(
                          'Brands',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        leading: const Icon(
                          Iconsax.element_3,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        titleAlignment: ListTileTitleAlignment.center,
                        onTap: () async {
                          // EasyLoading.show(status: "Please wait");

                          Get.to(() => const BannersScreen());

                          // EasyLoading.dismiss();
                        },
                        title: const Text(
                          'Banners',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        leading: const Icon(
                          Iconsax.layer,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ]),
                ))),
      ),
    );
  }
}
