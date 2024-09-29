import 'package:ads_pay_all/core/api_endpoints.dart';
import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/strings.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ScreenEarn extends StatefulWidget {
  const ScreenEarn({super.key});

  @override
  State<ScreenEarn> createState() => _ScreenEarnState();
}

class _ScreenEarnState extends State<ScreenEarn> {
  late InAppWebViewController _webViewController;
  late CookieManager _cookieManager;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _cookieManager = CookieManager.instance();
    // _setCookie();
  }

  // Function to set cookies
  // Future<void> _setCookie() async {
  //   await _cookieManager.setCookie(
  //     // url: Uri.parse("${ApiEndpoints.startingUrl}dashboard/earn"),
  //     url: WebUri.uri(
  //       Uri.parse(
  //         "https://mobile-adspayall.empyef.com/dashboard/earn",
  //       ),
  //     ),
  //     name: "authToken",
  //     value: StringConstants.TOKEN_STRING,
  //     domain:
  //         "https://mobile-adspayall.empyef.com/dashboard/earn", // Replace with your domain
  //     path: "/",
  //   );
  // }

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
            "Ads Publishers",
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
        body: InAppWebView(
          initialUrlRequest: URLRequest(
            // url: WebUri("https://pub.dev/packages/flutter_inappwebview")),
            url: WebUri.uri(
              Uri.parse(
                "${ApiEndpoints.startingUrl}earn?token=${StringConstants.TOKEN_STRING}",
                // "https://adspayall.empyef.com/source/load-all-publisher?token=${StringConstants.TOKEN_STRING}",
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
        ));
  }
}
