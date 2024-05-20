import 'package:admin_panel/common/widgets/appbar/appbar.dart';
import 'package:admin_panel/feature/shop/controllers/notification_controller.dart';
import 'package:admin_panel/utils/helpers/heleper_functions.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/validators/validation.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key, required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    final dark = MHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: const MAppBar(
        title: Text("Send Notification"),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: controller.notificationFormKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.title,
                validator: (value) =>
                    MValidator.validateEmptyText('Title', value),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.tag5),
                    labelText: "Title",
                    labelStyle:
                        TextStyle(color: dark ? MColors.light : MColors.dark)),
              ),
              const SizedBox(
                height: MSizes.spaceBtwInputFields,
              ),
              TextFormField(
                controller: controller.body,
                validator: (value) =>
                    MValidator.validateEmptyText('Body', value),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.tag5),
                    labelText: "Body",
                    labelStyle:
                        TextStyle(color: dark ? MColors.light : MColors.dark)),
              ),
              const SizedBox(
                height: MSizes.defaultSpace,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.sendNotification(token: token);
                    },
                    child: const Text("send notification")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
