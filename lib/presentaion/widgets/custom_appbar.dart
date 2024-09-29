import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.deviceWidth,
  });

  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: deviceWidth,
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "AdsPayAll",
              style: t18SemiBoldWhite,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: whiteColor,
              ),
              padding: EdgeInsets.zero,
            )
          ],
        ),
      ),
    );
  }
}
