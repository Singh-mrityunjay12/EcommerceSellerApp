import 'package:admin_panel/feature/screens/all_product_screen/widgets/edit_product_screen.dart';
import 'package:admin_panel/feature/shop/controllers/is_sale_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/shimmer/order_list_tile_shimmer.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../shop/controllers/products/product_controller.dart';

import 'widgets/add_product_screen.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    // final categoryDropDownController = Get.put(CategoryDropDownController());
    return Scaffold(
      appBar: MAppBar(
        title: const Text(
          "All Products",
        ),
        showBackArrow: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const AddProductScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.amber),
                child: const Icon(
                  Icons.add,
                  fill: 0.5,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
            future: controller.fetchAllFeaturedProducts(),
            builder: (context, snapshot) {
              const loader = MOrderListTileShimmer();

              final widget = MCloudHelperFunction.checkMultiRecordState(
                  snapshot: snapshot, loader: loader);
              if (widget != null) {
                print("Mrityuvvbn//////////////////////////////////////////");
                return widget;
              }

              //Product found
              final products = snapshot.data!;
              return products.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: MSizes.spaceBtwItems),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];

                        return Card(
                          child: ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  product.thumbnail,
                                  fit: BoxFit.cover,
                                )),
                            title: Text(product.title),
                            subtitle: Text(product.brand!.name),
                            trailing: IconButton(
                                onPressed: () {
                                  Get.to(() =>
                                      EditProductScreen(productModel: product));
                                  final bool isSale =
                                      product.salePrice > 0 ? true : false;
                                  final isSaleController =
                                      Get.put(IsSaleController());
                                  isSaleController.setIsSaleOldValue(isSale);
                                },
                                icon: const Icon(Icons.edit)),
                          ),
                        );
                      },
                    )
                  : const SizedBox(
                      child: Text('Mri'),
                    );
            }),
      ),
    );
  }
}
