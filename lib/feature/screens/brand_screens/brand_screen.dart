import 'package:admin_panel/common/widgets/appbar/appbar.dart';
import 'package:admin_panel/feature/screens/brand_screens/widgets/add_brand_screen.dart';
import 'package:admin_panel/feature/screens/brand_screens/widgets/edit_brand_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/shimmer/order_list_tile_shimmer.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';
import '../../shop/controllers/brand_controller.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    return Scaffold(
      appBar: MAppBar(
        title: const Text("All Brands Screen"),
        showBackArrow: true,
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(() => const AddNewBrandScreen(
                      isShow: true,
                    ));
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.amber),
                    child: const Icon(
                      Icons.add,
                      fill: 0.5,
                    ),
                  )))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
            future: controller.getFeaturedBrands(),
            builder: (context, snapshot) {
              const loader = MOrderListTileShimmer();
              print('//////////////////////////////${snapshot.data}');

              final widget = MCloudHelperFunction.checkMultiRecordState(
                  snapshot: snapshot, loader: loader);
              if (widget != null) {
                print("Mrityuvvbn//////////////////////////////////////////");
                return widget;
              }

              //Product found
              final brands = snapshot.data!;
              print('//////////////////////////$brands');
              return brands.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: MSizes.spaceBtwItems),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: brands.length,
                      itemBuilder: (context, index) {
                        final brand = brands[index];

                        return Card(
                          child: Container(
                            height: 100,
                            child: ListTile(
                              leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    brand.image,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  )),
                              title: Text(brand.name),
                              trailing: IconButton(
                                  onPressed: () {
                                    Get.to(() => EditBrandScreen(
                                          isShow: true,
                                          brandModel: brand,
                                        ));
                                    // final bool isSale =
                                    //     product.salePrice > 0 ? true : false;
                                    // final isSaleController =
                                    //     Get.put(IsSaleController());
                                    // isSaleController.setIsSaleOldValue(isSale);
                                  },
                                  icon: const Icon(Icons.edit)),
                            ),
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
