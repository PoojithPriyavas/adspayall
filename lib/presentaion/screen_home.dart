import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:ads_pay_all/presentaion/screen_accounts.dart';
import 'package:ads_pay_all/presentaion/screen_advertise.dart';
import 'package:ads_pay_all/presentaion/screen_earn.dart';
import 'package:ads_pay_all/presentaion/screen_history.dart';
import 'package:ads_pay_all/presentaion/screen_notifications.dart';
import 'package:ads_pay_all/presentaion/screen_profile.dart';
import 'package:ads_pay_all/presentaion/screen_redeem_code.dart';
import 'package:ads_pay_all/presentaion/widgets/custom_dashboard_button.dart';
import 'package:ads_pay_all/routes/routes.dart';
import 'package:ads_pay_all/utils/enums.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final safeAreaheight = MediaQuery.of(context).padding.top;
    var aspectRatio = ((deviceWidth / 2) / (deviceHeight / 5)) + 0.1;

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
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
          actions: [],
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
                NavigationHandler.navigateWithAnimation(
                    context, ScreenEarn(), SlideDirection.slideLeft);
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
