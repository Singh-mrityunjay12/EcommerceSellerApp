import 'package:admin_panel/common/widgets/appbar/appbar.dart';
import 'package:admin_panel/feature/screens/category_screen/widgets/add_category_screen.dart';
import 'package:admin_panel/feature/shop/controllers/category_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../common/widgets/shimmer/loadingIndicator.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Scaffold(
      appBar: MAppBar(
        title: Text("All Category"),
        showBackArrow: true,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const AddCategoryScreen());
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
      body: FutureBuilder(
          future: categoryController.fetchCategories1(),
          builder: (context, snapshot) {
            const loader = MShimmerEffect(width: double.infinity, height: 40);
            print('//////////////////////////////${snapshot.data}');

            final widget = MCloudHelperFunction.checkMultiRecordState(
                snapshot: snapshot, loader: loader);
            if (widget != null) {
              print("Mrityuvvbn//////////////////////////////////////////");
              return widget;
            }

            //Product found
            final categories = snapshot.data!;

            return categories.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: MSizes.spaceBtwItems),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return Card(
                        child: Container(
                          height: 100,
                          child: ListTile(
                            leading: ClipRRect(
                                // borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                              category.image,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )),
                            title: Text(category.name),
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
    );
  }
}
