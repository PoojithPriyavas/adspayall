import 'package:ads_pay_all/core/api_endpoints.dart';
import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/strings.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({super.key});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  late InAppWebViewController _webViewController;
  late CookieManager _cookieManager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
          title: Text(
            "User Profile",
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
        body: Container(
          height: deviceHeight,
          width: deviceWidth,
          color: whiteColor,
          child: InAppWebView(
            initialSettings: InAppWebViewSettings(
              underPageBackgroundColor: whiteColor,
              transparentBackground: true,
            ),
            initialUrlRequest: URLRequest(
              url: WebUri.uri(
                Uri.parse(
                  "${ApiEndpoints.startingUrl}profile?token=${StringConstants.TOKEN_STRING}",
                ),
              ),
            ),
            onWebViewCreated: (controller) {
              _webViewController = controller;
              // _setCookie();
            },
            onLoadStart: (controller, url) {
              print('Page started loading: $url');
            },
            onLoadStop: (controller, url) async {
              // InAppWebViewController.clearAllCache;
              print('Page finished loading: $url');

              // // Optionally, retrieve cookies for debugging
              // final cookies = await _cookieManager.getCookies(
              //   url: WebUri.uri(
              //     Uri.parse(
              //       "${ApiEndpoints.startingUrl}dashboard/earn",
              //     ),
              //   ),
              // );
              // print('Cookies: $cookies');
            },
            onProgressChanged: (controller, progress) {
              print('Loading progress: $progress%');
            },
          ),
        ));
  }
}
