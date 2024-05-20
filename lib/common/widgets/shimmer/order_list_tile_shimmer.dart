import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/constants/sizes.dart';
import 'loadingIndicator.dart';

class MOrderListTileShimmer extends StatelessWidget {
  const MOrderListTileShimmer({
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
                      MShimmerEffect(width: 200, height: 50)
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
