import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import 'loadingIndicator.dart';

class MCategoryShimmer extends StatelessWidget {
  const MCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => const SizedBox(
                  width: MSizes.spaceBtwItems,
                ),
            itemCount: itemCount,
            itemBuilder: (_, __) {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MShimmerEffect(
                    width: 55,
                    height: 55,
                    radius: 55,
                  ),
                  SizedBox(
                    height: MSizes.spaceBtwItems / 2,
                  ),
                  MShimmerEffect(width: 55, height: 8)
                ],
              );
            }));
  }
}
