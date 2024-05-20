import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/shimmer/order_list_tile_shimmer.dart';
import '../../../../utils/constants/colors.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../common/widgets/appbar/appbar.dart';

import '../../authentication/persionalizations/controllers/user_controller.dart';
import 'widgets/all_order_logged_in_user.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      appBar: const MAppBar(
        title: Text(
          "All Orders",
        ),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
            future: controller.getAllUsers(),
            builder: (context, snapshot) {
              const loader = MOrderListTileShimmer();

              final widget = MCloudHelperFunction.checkMultiRecordState(
                  snapshot: snapshot, loader: loader);
              if (widget != null) {
                print("Mrityuvvbn//////////////////////////////////////////");
                return widget;
              }

              //Product found
              final users = snapshot.data!;
              return users.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: MSizes.spaceBtwItems),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: MColors.appMainColor,
                            child: Text(
                              user.firstName.substring(0, 1),
                              style: const TextStyle(color: MColors.white),
                            ),
                          ),
                          title: Text(user.fullName),
                          subtitle: Text(user.email),
                          trailing: IconButton(
                              onPressed: () {
                                Get.to(() => AllOrderLoggedInUser(
                                      userId: user.id,
                                      userName: user.fullName,
                                      email: user.email,
                                      token: user.token,
                                    ));
                              },
                              icon:
                                  const Icon(Icons.arrow_forward_ios_rounded)),
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
