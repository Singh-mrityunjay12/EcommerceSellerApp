import 'package:admin_panel/common/widgets/appbar/appbar.dart';
import 'package:admin_panel/feature/screens/banner_screens.dart/widgets/add_banner_screen.dart';
import 'package:admin_panel/feature/shop/controllers/banner_controller.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/shimmer/loadingIndicator.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = Get.put(BannerController());
    return Scaffold(
      appBar: MAppBar(
        title: Text("All Banners Screen"),
        showBackArrow: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const AddBannerScreen());
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
            future: bannerController.fetchBanners(),
            builder: (context, snapshot) {
              const loader =
                  MShimmerEffect(width: double.infinity, height: 190);
              print('//////////////////////////////${snapshot.data}');

              final widget = MCloudHelperFunction.checkMultiRecordState(
                  snapshot: snapshot, loader: loader);
              if (widget != null) {
                print("Mrityuvvbn//////////////////////////////////////////");
                return widget;
              }

              //Product found
              final banners = snapshot.data!;

              return banners.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: MSizes.spaceBtwItems),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: banners.length,
                      itemBuilder: (context, index) {
                        final banner = banners[index];

                        return Card(
                          child: Container(
                            height: 100,
                            child: ListTile(
                              leading: ClipRRect(
                                  // borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                banner.imageUrl,
                                height: 300,
                                width: 100,
                                fit: BoxFit.cover,
                              )),
                              title: Text(banner.name),
                              trailing: IconButton(
                                  onPressed: () {
                                    // Get.to(() =>
                                    //     EditProductScreen(productModel: product));
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
