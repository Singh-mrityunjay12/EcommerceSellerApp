import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/heleper_functions.dart';

class MSectionHeading extends StatelessWidget {
  const MSectionHeading({
    this.onPressed,
    this.textColor,
    this.buttonTitle = "View all",
    required this.title,
    this.showActionButton = true,
    super.key,
  });

  final Color? textColor;
  final bool showActionButton;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(
              color: MHelperFunction.isDarkMode(context)
                  ? MColors.light
                  : textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}
