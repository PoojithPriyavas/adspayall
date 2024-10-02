import 'dart:developer';

import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/constants.dart';
import 'package:ads_pay_all/core/shared_pref_data.dart';
import 'package:ads_pay_all/core/strings.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:ads_pay_all/provider/redeem_provider.dart';
import 'package:ads_pay_all/services/redeem_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:provider/provider.dart';
import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';

class ScreenRedeemCode extends StatefulWidget {
  const ScreenRedeemCode({super.key});

  @override
  State<ScreenRedeemCode> createState() => _ScreenRedeemCodeState();
}

class _ScreenRedeemCodeState extends State<ScreenRedeemCode> {
  bool _switch = false;
  bool _redeemClicked = false;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final redeemProvider = Provider.of<RedeemProvider>(context);
    final RedeemService redeemService = RedeemService();
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
                    controller: redeemProvider.controller,
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
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.blueAccent.shade200),
                        shape: WidgetStatePropertyAll(ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () async {
                      try {
                        final redeemCode = redeemProvider.controller.text;

                        if (redeemCode.isEmpty) {
                          log("empty string");
                        } else {
                          setState(() {
                            _redeemClicked = true;
                          });
                          final response = await redeemService.postApaCode(
                              redeemCode, StringConstants.TOKEN_STRING);

                          setState(() {
                            _redeemClicked = false;
                          });

                          if (response == "Success") {
                            awesomeTopSnackbar(
                              backgroundColor: Colors.green,
                              textStyle: t18RegularWhite,
                              context,
                              "Redeemed Successfully",
                            );
                          } else if (response == "APA Code Already Redeemed") {
                            awesomeTopSnackbar(
                              backgroundColor: Colors.red,
                              textStyle: t18RegularWhite,
                              context,
                              "APA Code Already Redeemed",
                            );
                          } else if (response ==
                              "Not available for your postcode/zipcode") {
                            awesomeTopSnackbar(
                              backgroundColor: Colors.red,
                              textStyle: t18RegularWhite,
                              context,
                              "Not available for your postcode/zipcode",
                            );
                          } else if (response == "Code Expired") {
                            awesomeTopSnackbar(
                              backgroundColor: Colors.red,
                              textStyle: t18RegularWhite,
                              context,
                              "Code Expired",
                            );
                          } else if (response == "Invalid APA Code") {
                            awesomeTopSnackbar(
                              backgroundColor: Colors.red,
                              textStyle: t18RegularWhite,
                              context,
                              "Invalid APA Code",
                            );
                          } else if (response == "Incomplete User Profile") {
                            awesomeTopSnackbar(
                              backgroundColor: Colors.red,
                              textStyle: t18RegularWhite,
                              context,
                              "Incomplete User Profile",
                            );
                          } else if (response == "Not logged in") {
                            log("not logged in");
                            awesomeTopSnackbar(
                              backgroundColor: Colors.red,
                              textStyle: t18RegularWhite,
                              context,
                              "Not logged in",
                            );
                          } else if (response == "Network Error") {
                            awesomeTopSnackbar(
                              backgroundColor: Colors.red,
                              textStyle: t18RegularWhite,
                              context,
                              "Network Error",
                            );
                          }
                        }
                      } catch (e) {
                        log("error is $e");
                      }
                    },
                    child: _redeemClicked == true
                        ? CircularProgressIndicator(
                            color: whiteColor,
                          )
                        : const Text("Redeem"),
                  )),
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
                    onChanged: (value) async {
                      try {
                        final status =
                            await FlutterOverlayWindow.isPermissionGranted();

                        print(" statsu si $status");
                        if (status == true) {
                          final overlayActive =
                              await FlutterOverlayWindow.isActive();

                          log(" overlay is active or not : $overlayActive");

                          if (overlayActive == true) {
                            await FlutterOverlayWindow.closeOverlay();
                            setState(() {
                              _switch = false;
                            });
                          } else {
                            await FlutterOverlayWindow.showOverlay(
                              enableDrag: true,
                              overlayTitle: "X-SLAYER",
                              overlayContent: 'Overlay Enabled',
                              // flag: OverlayFlag.defaultFlag,
                              flag: OverlayFlag.focusPointer,
                              visibility:
                                  NotificationVisibility.visibilityPublic,
                              // positionGravity: PositionGravity.left,
                              height: (MediaQuery.of(context).size.height * 0.6)
                                  .toInt(),
                              // width: WindowSize.matchParent,
                              alignment: OverlayAlignment.centerRight,
                              width: 120,
                              // startPosition: const OverlayPosition(0, -259),
                            );
                            setState(() {
                              _switch = true;
                            });
                          }
                        } else {
                          final bool? res =
                              await FlutterOverlayWindow.requestPermission();
                          if (res == true) {
                            final overlayActive =
                                await FlutterOverlayWindow.isActive();

                            log(" overlay is active or not : $overlayActive");

                            if (overlayActive == true) {
                              await FlutterOverlayWindow.closeOverlay();
                              setState(() {
                                _switch = false;
                              });
                            } else {
                              await FlutterOverlayWindow.showOverlay(
                                enableDrag: true,
                                overlayTitle: "X-SLAYER",
                                overlayContent: 'Overlay Enabled',
                                flag: OverlayFlag.defaultFlag,
                                visibility:
                                    NotificationVisibility.visibilityPublic,
                                // positionGravity: PositionGravity.left,
                                height:
                                    (MediaQuery.of(context).size.height * 0.6)
                                        .toInt(),
                                // width: WindowSize.matchParent,
                                alignment: OverlayAlignment.centerRight,
                                width: 100,
                                // startPosition: const OverlayPosition(0, -259),
                              );
                              setState(() {
                                _switch = true;
                              });
                            }
                          } else {
                            log("user not given permission");
                          }
                        }
                      } catch (e) {
                        log("error in the screen redeem code overlay clicked is $e");
                      }
                    },
                  ),
                  kWidth5,
                  Text(
                    "Open floating overlay tool",
                    style: t14SemiBoldBlack,
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    final SharedPrefData sharedPrefData = SharedPrefData();

                    final newToken = await sharedPrefData.getToken();
                    log("token is $newToken");
                  },
                  child: Text("data"))
            ],
          ),
        ),
      ),
    );
  }
}
