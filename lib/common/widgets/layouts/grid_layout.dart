import 'package:flutter/cupertino.dart';

import '../../../utils/constants/sizes.dart';

class MGridLayOut extends StatelessWidget {
  const MGridLayOut(
      {super.key,
      required this.itemCount,
      this.mainAxisExtend = 288,
      required this.itemBuilder});

  final int itemCount;
  final double? mainAxisExtend;
  final Widget? Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: MSizes.gridViewSpacing,
            crossAxisSpacing: MSizes.gridViewSpacing,
            mainAxisExtent: mainAxisExtend),
        itemBuilder: itemBuilder);
  }
}
