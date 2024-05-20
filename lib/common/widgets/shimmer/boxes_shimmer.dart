import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import 'loadingIndicator.dart';

class MBoxesShimmer extends StatelessWidget {
  const MBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: MShimmerEffect(width: 150, height: 110)),
            SizedBox(
              width: MSizes.spaceBtwItems,
            ),
            Expanded(child: MShimmerEffect(width: 150, height: 110)),
            SizedBox(
              width: MSizes.spaceBtwItems,
            ),
            Expanded(child: MShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}
