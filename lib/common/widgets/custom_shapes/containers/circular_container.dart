import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';

class MCircularContainer extends StatelessWidget {
  const MCircularContainer({
    this.child,
    this.height = 400,
    this.width = 400,
    this.padding = 0,
    this.margin,
    this.radius = 400,
    this.backgroundColor = MColors.white,
    super.key,
  });
  final double? width;
  final double? height;
  final double? radius;
  final double? padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding!),
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
