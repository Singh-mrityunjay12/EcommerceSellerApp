import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import 'loadingIndicator.dart';

class MHorizontalProductShimmer extends StatelessWidget {
  const MHorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: MSizes.spaceBtwSection),
      height: 120,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: MSizes.spaceBtwItems,
        ),
        itemCount: itemCount,
        itemBuilder: (_, __) => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Image
            MShimmerEffect(width: 120, height: 120),
            SizedBox(
              width: MSizes.spaceBtwItems,
            ),
            //Text
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MSizes.spaceBtwItems / 2,
                ),
                MShimmerEffect(width: 120, height: 15),
                SizedBox(
                  height: MSizes.spaceBtwItems / 2,
                ),
                MShimmerEffect(width: 110, height: 15),
                SizedBox(
                  height: MSizes.spaceBtwItems / 2,
                ),
                MShimmerEffect(width: 100, height: 15),
              ],
            )
          ],
        ),
      ),
    );
  }
}
