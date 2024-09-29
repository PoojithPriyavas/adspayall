/// This class is to get gradient color.

import 'package:ads_pay_all/core/colors.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  GradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                ColorConstants.appStartColor,
                ColorConstants.appEndColor
              ],
            ),
          ),
        ),
        child,
      ],
    );
  }
}
