import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class MPrimaryHeaderContainer extends StatelessWidget {
  const MPrimaryHeaderContainer({
    required this.child,
    super.key,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MCurvedEdgeWidget(
      child: Container(
        color: MColors.primary,
        padding: const EdgeInsets.all(0),
        child: SizedBox(
          // height: 370,
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: MCircularContainer(
                  backgroundColor: MColors.white.withOpacity(0.17),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: MCircularContainer(
                  backgroundColor: MColors.white.withOpacity(0.17),
                ),
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
