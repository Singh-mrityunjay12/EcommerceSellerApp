import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../utils/constants/image_string.dart';

Widget applogoWidget() {
  //using velocity-x here

  return Image.asset(
    MImage.icSplashBg,
    // color: MColors.error,
  ).box.size(140, 140).padding(const EdgeInsets.all(10)).rounded.make();
}
