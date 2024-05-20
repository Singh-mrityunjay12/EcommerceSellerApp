import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/heleper_functions.dart';

class MSearchContainer extends StatelessWidget {
  const MSearchContainer(
      {super.key,
      required this.text,
      this.icon,
      this.showBackground = true,
      this.showBorder = true,
      this.padding =
          const EdgeInsets.symmetric(horizontal: MSizes.defaultSpace)});

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    return Padding(
      padding: padding,
      child: Container(
        width: MDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.all(MSizes.md),
        decoration: BoxDecoration(
            color: showBackground
                ? dark
                    ? MColors.dark
                    : MColors.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(MSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: MColors.grey) : null),
        child: Row(children: [
          Icon(
            icon,
            color: MColors.grey,
          ),
          const SizedBox(
            width: MSizes.spaceBtwItems,
          ),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(color: MColors.darkGrey),
          )
        ]),
      ),
    );
  }
}
