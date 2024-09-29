import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/constants.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:flutter/material.dart';

class CustomDashboardButton extends StatelessWidget {
  final String label;
  final String image;
  final void Function()? callBack;

  const CustomDashboardButton(
      {super.key, required this.label, required this.image, this.callBack});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: whiteColor,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 0))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 50.0,
              width: 50.0,
              color: label == "Website"
                  ? null
                  : Color.fromARGB(255, 245, 131, 169),
            ),
            kHeight20,
            Text(
              label,
              style: t16MediumBlack,
            ),
          ],
        ),
      ),
    );
  }
}
