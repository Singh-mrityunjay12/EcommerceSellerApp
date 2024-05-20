import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/shimmer/order_list_tile_shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/bottom_sheet_function.dart';
import '../../../shop/controllers/products/order_controller.dart';

class AllOrderLoggedInUser extends StatelessWidget {
  const AllOrderLoggedInUser(
      {super.key,
      required this.userId,
      required this.userName,
      required this.email,
      required this.token});

  final String userId;
  final String userName;
  final String email;
  final String token;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final bottomSheetController = Get.put(BottomSheetModel());
    return Scaffold(
      appBar: MAppBar(
        title: Text(
          userName.toString(),
        ),
        showBackArrow: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder(
              future: controller.fetchUsersOrders1(userId),
              builder: (context, snapshot) {
                const loader = MOrderListTileShimmer();

                final widget = MCloudHelperFunction.checkMultiRecordState(
                    snapshot: snapshot, loader: loader);
                if (widget != null) {
                  print("Mrityuvvbn//////////////////////////////////////////");
                  return widget;
                }

                //Product found
                final orders = snapshot.data!;
                return orders.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: MSizes.spaceBtwItems),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: MColors.appMainColor,
                              child: Text(
                                order.address!.name.substring(0, 1),
                                style: const TextStyle(color: MColors.white),
                              ),
                            ),
                            title: Text(order.address!.name),
                            subtitle: Text(order.id),
                            trailing: IconButton(
                                onPressed: () {
                                  bottomSheetController.showBottomSheet(
                                      order, email, token);
                                  print(
                                      '////////////////////////////////${order.uuid}');
                                },
                                icon: const Icon(Icons.more_vert)),
                          );
                        },
                      )
                    : const SizedBox(
                        child: Text('Mri'),
                      );
              })),
    );
  }
}
