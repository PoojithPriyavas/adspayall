import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:flutter/material.dart';

class CustomAdsWidgets extends StatelessWidget {
  const CustomAdsWidgets(
      {super.key, required this.deviceWidth, required this.label, this.image});

  final double deviceWidth;
  final String label;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (deviceWidth * 0.5) - 30,
      height: (deviceWidth * 0.5) - 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: const Offset(0, 2))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: (deviceWidth * 0.5) - 103,
              width: (deviceWidth * 0.5) - 30,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Image.asset("assets/images/image.png"),
              ),
            ),
            Container(
              height: 55,
              width: (deviceWidth * 0.5) - 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor,
                // border:
                //     Border.all(color: Colors.grey.withOpacity(0.), width: 1),
              ),
              child: Center(
                  child: Text(
                label,
                style: t16MediumBlack,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
            )
          ],
        ),
      ),
    );
  }
}
