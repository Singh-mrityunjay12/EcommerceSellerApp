import 'package:admin_panel/common/widgets/shimmer/loadingIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/constants/sizes.dart';

class MListTileShimmer extends StatelessWidget {
  const MListTileShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const Column(
            children: [
              Row(
                children: [
                  MShimmerEffect(
                    width: 50,
                    height: 50,
                    radius: 50,
                  ),
                  SizedBox(
                    width: MSizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MShimmerEffect(width: 170, height: 12),
                      SizedBox(
                        height: MSizes.spaceBtwItems / 2,
                      ),
                      MShimmerEffect(width: 300, height: 100)
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MSizes.spaceBtwItems,
              )
            ],
          );
        });
  }
}
