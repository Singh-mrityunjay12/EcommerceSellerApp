import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/heleper_functions.dart';

class MTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MTabBar({super.key, required this.tabs});

  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = MHelperFunction.isDarkMode(context);
    return Material(
      child: TabBar(
          isScrollable: true,
          indicatorColor: MColors.primary,
          unselectedLabelColor: MColors.darkGrey,
          labelColor: dark ? MColors.white : MColors.primary,
          tabs: tabs),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(MDeviceUtils.getAppBarHeight());
}
