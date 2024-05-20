import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/heleper_functions.dart';

class MAnimationLoaderWidget extends StatelessWidget {
  const MAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 200),
          // Lottie.asset(animation,
          //     width: MediaQuery.of(context).size.width * 0.6),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: AssetImage(animation),
              width: MHelperFunction.screenWidth() * 0.6,
            ),
          ),
          // Display Lottie animation
          const SizedBox(
            height: MSizes.defaultSpace,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: Colors.black,
                  // heightDelta: 33,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: MSizes.defaultSpace,
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                      onPressed: onActionPressed,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: MColors.dark),
                      child: Text(
                        actionText!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: MColors.light),
                      )),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
