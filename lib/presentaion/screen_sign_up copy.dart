import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/constants.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:ads_pay_all/presentaion/GradientBackground.dart';
import 'package:flutter/material.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GradientBackground(
        child: SizedBox(
          height: deviceHeight,
          width: deviceWidth,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  kHeight20,
                  Text(
                    "Create New Account",
                    style: t24SemiBoldWhite,
                    textAlign: TextAlign.left,
                  ),
                  kHeight30,
                  Text(
                    "Already Registered?",
                    style: t16MediumWhite,
                    textAlign: TextAlign.left,
                  ),
                  kHeight30,
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      children: [
                        // first part
                        Column(
                          children: [
                            Container(
                              height: 350,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(255, 255, 255, 0.3),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    kHeight10,
                                    Text(
                                      "You need to be 16 years or older\nto create an Audience Member account.",
                                      style: t20MediumRed.copyWith(
                                          color: whiteColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    kHeight20,
                                    Text(
                                      "If you are NOT yet 16 years old,\nselect",
                                      style: t20MediumRed.copyWith(
                                          color: whiteColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    kHeight20,
                                    SizedBox(
                                      width: deviceWidth - 30,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                const WidgetStatePropertyAll(
                                                    lightGreyColor),
                                            elevation:
                                                const WidgetStatePropertyAll(2),
                                            shape: WidgetStatePropertyAll(
                                                ContinuousRectangleBorder(
                                                    side: const BorderSide(
                                                        color: whiteColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)))),
                                        onPressed: () async {},
                                        child: Text(
                                          "Exit App to Uninstall",
                                          style: t16RegularWhite.copyWith(
                                              color: greyColor),
                                        ),
                                      ),
                                    ),
                                    kHeight20,
                                    Text(
                                      "If you are 16 years or older, select",
                                      style: t20MediumRed.copyWith(
                                          color: whiteColor),
                                      textAlign: TextAlign.center,
                                    ),
                                    kHeight10,
                                  ],
                                ),
                              ),
                            ),
                            kHeight30,
                            SizedBox(
                              width: deviceWidth - 30,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: const WidgetStatePropertyAll(2),
                                    backgroundColor:
                                        const WidgetStatePropertyAll(blueColor),
                                    shape: WidgetStatePropertyAll(
                                        ContinuousRectangleBorder(
                                            side: const BorderSide(
                                                color: whiteColor),
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                                onPressed: () async {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                },
                                child: Text(
                                  "Next",
                                  style: t16RegularWhite,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Second Part

                        Column(
                          children: [
                            Container(
                              height: 350,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(255, 255, 255, 0.3),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: <Widget>[
                                    kHeight20,
                                    TextField(
                                      cursorColor: blueColor,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        hintText: "Enter Email Address",
                                        hintStyle: t12MediumGrey,
                                        filled: true,
                                        border: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: whiteColor)),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: whiteColor)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: blueColor)),
                                        fillColor: whiteColor,
                                        focusColor: whiteColor,
                                      ),
                                    ),
                                    kHeight30,
                                    Text(
                                      "*This will be your  'username' to log in as a member on the AdsPayAll platform. Your email address will not be shared publicly.",
                                      style: t12MediumWhite,
                                      textAlign: TextAlign.left,
                                    ),
                                    kHeight20,
                                    kHeight10,
                                  ],
                                ),
                              ),
                            ),
                            kHeight30,
                            SizedBox(
                              width: deviceWidth - 30,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    elevation: const WidgetStatePropertyAll(2),
                                    backgroundColor:
                                        const WidgetStatePropertyAll(blueColor),
                                    shape: WidgetStatePropertyAll(
                                        ContinuousRectangleBorder(
                                            side: const BorderSide(
                                                color: whiteColor),
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                                onPressed: () async {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                },
                                child: Text(
                                  "Next",
                                  style: t16RegularWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  kHeight20,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Terms and Conditions",
                        style: t12MediumWhite,
                      ),
                      Text(
                        "Privacy Policy",
                        style: t12MediumWhite,
                      ),
                    ],
                  ),
                  kHeight10
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
