import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/shared_pref_data.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:ads_pay_all/presentaion/screen_accounts.dart';
import 'package:ads_pay_all/presentaion/screen_advertise.dart';
import 'package:ads_pay_all/presentaion/screen_earn.dart';
import 'package:ads_pay_all/presentaion/screen_forget_password.dart';
import 'package:ads_pay_all/presentaion/screen_history.dart';
import 'package:ads_pay_all/presentaion/screen_login.dart';
import 'package:ads_pay_all/presentaion/screen_notifications.dart';
import 'package:ads_pay_all/presentaion/screen_profile.dart';
import 'package:ads_pay_all/presentaion/screen_redeem_code.dart';
import 'package:ads_pay_all/presentaion/widgets/custom_dashboard_button.dart';
import 'package:ads_pay_all/routes/routes.dart';
import 'package:ads_pay_all/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> with WidgetsBindingObserver {
  // always on display part
  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  String? latestMessageFromOverlay;
  AppLifecycleState? _notification;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("state in the screen home is $state");

    if (state == AppLifecycleState.detached) {
      // Close the overlay if the app is not visible
      FlutterOverlayWindow.closeOverlay();
    }
    setState(() {
      _notification = state;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _kPortNameHome,
    );
    log("$res: OVERLAY");

    _receivePort.listen((message) async {
      log("message from OVERLAY: $message");
      log("lyfecycle is $_notification");
      if (message == "Ads") {
        NavigationHandler.navigateWithAnimation(
            context, const ScreenEarn(), SlideDirection.slideLeft);
        log("this is printing - adssss");
      }

      if (message == "Exit") {
        // NavigationHandler.navigateWithAnimation(
        //     context, const ScreenEarn(), SlideDirection.slideLeft);
        SystemNavigator.pop();
        log("this is printing - adssss");
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final safeAreaheight = MediaQuery.of(context).padding.top;
    var aspectRatio = ((deviceWidth / 2) / (deviceHeight / 5)) + 0.1;
    final SharedPrefData sharedPrefData = SharedPrefData();
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          foregroundColor: whiteColor,
          title: Text(
            "AdsPayAll",
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton(
                color: whiteColor,
                padding: const EdgeInsets.all(10),
                tooltip: 'Menu',
                child: const Icon(
                  Icons.more_vert,
                  size: 28.0,
                  color: Colors.white,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: InkWell(
                    child: Row(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              // Icons.logout,
                              CupertinoIcons.square_arrow_right,

                              color: Colors.black54,
                              size: 22.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                              ),
                              child: Text("Logout", style: t14RegularBlack),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () async {
                      await sharedPrefData.clearSharedPref();
                      Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (context) {
                          return ScreenLogin();
                        },
                      ));
                    },
                  )),
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context)
                            .pushReplacement(CupertinoPageRoute(
                          builder: (context) {
                            return ScreenForgetPassword(
                              loggedIn: true,
                            );
                          },
                        ));
                      },
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.settings,
                                color: Colors.black54,
                                size: 22.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10.0,
                                ),
                                child: Text("Change Password",
                                    style: t14RegularBlack),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: aspectRatio,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          children: [
            // SvgPicture.asset("assets/images/noto.svg"),
            CustomDashboardButton(
              callBack: () {
                NavigationHandler.navigateWithAnimation(
                    context, const ScreenEarn(), SlideDirection.slideLeft);
              },
              label: "Earn",
              image: "assets/icons/earn.png",
            ),
            CustomDashboardButton(
              callBack: () {
                NavigationHandler.navigateWithAnimation(context,
                    const ScreenRedeemCode(), SlideDirection.slideLeft);
              },
              label: "Redeem",
              image: "assets/icons/redeem.png",
            ),
            CustomDashboardButton(
              callBack: () {
                NavigationHandler.navigateWithAnimation(
                    context, const ScreenProfile(), SlideDirection.slideLeft);
              },
              label: "Profile",
              image: "assets/icons/profile.png",
            ),
            CustomDashboardButton(
              callBack: () {
                NavigationHandler.navigateWithAnimation(
                    context, const ScreenAdvertise(), SlideDirection.slideLeft);
                // NavigationHandler.navigateTo(context, ScreenAdvertise());
              },
              label: "Advertise",
              image: "assets/icons/advertiser.png",
            ),
            CustomDashboardButton(
              label: "Accounts",
              image: "assets/icons/accounting.png",
              callBack: () {
                NavigationHandler.navigateWithAnimation(
                    context, const ScreenAccounts(), SlideDirection.slideLeft);
              },
            ),
            CustomDashboardButton(
              label: "History",
              callBack: () {
                NavigationHandler.navigateWithAnimation(
                    context, const ScreenHistory(), SlideDirection.slideLeft);
              },
              image: "assets/icons/history.png",
            ),
            CustomDashboardButton(
              label: "Notification",
              image: "assets/icons/notification.png",
              callBack: () {
                NavigationHandler.navigateWithAnimation(context,
                    const ScreenNotifications(), SlideDirection.slideLeft);
              },
            ),
            const CustomDashboardButton(
              label: "Terms/Policies",
              image: "assets/icons/terms-and-conditions.png",
            ),
            const CustomDashboardButton(
              label: "Website",
              image: "assets/icons/bg-logo.png",
            ),
            CustomDashboardButton(
              callBack: () {
                // NavigationHandler.navigateWithAnimation(
                //     context, ScreenEarn(), SlideDirection.slideLeft);
              },
              label: "FAQs",
              image: "assets/icons/faq.png",
            ),
          ],
        ));
  }
}

class IosStyleToast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  Text('Succeed')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
