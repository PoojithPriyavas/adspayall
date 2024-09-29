import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/constants.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:flutter/material.dart';

class ScreenRedeemCode extends StatefulWidget {
  const ScreenRedeemCode({super.key});

  @override
  State<ScreenRedeemCode> createState() => _ScreenRedeemCodeState();
}

class _ScreenRedeemCodeState extends State<ScreenRedeemCode> {
  bool _switch = false;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            )),
        title: Text(
          "Redeem Code",
          style: t18SemiBoldWhite,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.pinkAccent],
              stops: [0.0, 1.0],
            ),
          ),
        ),
        actions: [],
      ),
      body: SizedBox(
        height: deviceHeight,
        width: deviceWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              kHeight50,
              SizedBox(
                  width: deviceWidth - 40,
                  height: 45,
                  child: TextField(
                    style: t14RegularBlack,
                    cursorColor: Colors.blueAccent.withOpacity(0.4),
                    decoration: InputDecoration(
                      hintText: "Key in the AdsPayAll Code",
                      hintStyle: t12MediumGrey,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.blueAccent.withOpacity(0.4),
                          )),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                          )),
                    ),
                  )),
              kHeight15,
              SizedBox(
                  width: deviceWidth - 40,
                  height: 45,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              const WidgetStatePropertyAll(whiteColor),
                          backgroundColor: WidgetStatePropertyAll(
                              Colors.blueAccent.shade200),
                          shape: WidgetStatePropertyAll(
                              ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {},
                      child: const Text("Redeem"))),
              kHeight50,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                    // trackColor: const WidgetStatePropertyAll(lightGreyColor),
                    activeColor: whiteColor,
                    inactiveThumbColor: whiteColor,
                    activeTrackColor: Colors.blueAccent.shade200,
                    inactiveTrackColor: lightGreyColor,
                    trackOutlineWidth: const WidgetStatePropertyAll(0),
                    trackOutlineColor: _switch == false
                        ? const WidgetStatePropertyAll(lightGreyColor)
                        : WidgetStatePropertyAll(Colors.blueAccent.shade200),
                    value: _switch,
                    onChanged: (value) {
                      setState(() {
                        _switch = value;
                      });
                    },
                  ),
                  kWidth5,
                  Text(
                    "Open floating overlay tool",
                    style: t14SemiBoldBlack,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
