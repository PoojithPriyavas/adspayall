import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';
import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/constants.dart';
import 'package:ads_pay_all/core/shared_pref_data.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:ads_pay_all/services/redeem_service.dart';
import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:bg_launcher/bg_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class MessangerChatHead extends StatefulWidget {
  const MessangerChatHead({super.key});

  @override
  State<MessangerChatHead> createState() => _MessangerChatHeadState();
}

class _MessangerChatHeadState extends State<MessangerChatHead>
    with WidgetsBindingObserver {
  Color color = const Color(0xFFFFFFFF);
  BoxShape _currentShape = BoxShape.circle;
  static const String _kPortNameOverlay = 'OVERLAY';
  static const String _kPortNameHome = 'UI';
  final _receivePort = ReceivePort();
  SendPort? homePort;
  String? messageFromOverlay;
  bool? redeemOverlaySelected;
  final TextEditingController controller = TextEditingController();
  bool _redeemClicked = false;

  @override
  void initState() {
    log("init state called");
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    redeemOverlaySelected = false;
    _currentShape = BoxShape.circle;
    if (homePort != null) return;
    final res = IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      _kPortNameOverlay,
    );
    log("$res : HOME");
    _receivePort.listen((message) {
      log("message from UI: $message");
      setState(() {
        messageFromOverlay = 'message from UI: $message';
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);

    _currentShape = BoxShape.circle;
    redeemOverlaySelected = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("status is $state");
    // Check if the app is in background or detached state
    // if (state == AppLifecycleState.paused ||
    //     state == AppLifecycleState.detached) {
    //   // Close the overlay if the app is not visible
    //   FlutterOverlayWindow.closeOverlay();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final RedeemService redeemService = RedeemService();
    final SharedPrefData sharedPrefData = SharedPrefData();
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      child: GestureDetector(
        onTap: () async {
          setState(() {
            redeemOverlaySelected = false;
          });
          if (_currentShape == BoxShape.rectangle) {
            await FlutterOverlayWindow.resizeOverlay(50, 100, true);
            setState(() {
              _currentShape = BoxShape.circle;
            });
          } else {
            await FlutterOverlayWindow.resizeOverlay(
              50,
              400,
              true,
            );
            setState(() {
              _currentShape = BoxShape.rectangle;
            });
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: _currentShape,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                redeemOverlaySelected == true
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                // kHeight50,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            redeemOverlaySelected = false;
                                            _currentShape == BoxShape.circle;
                                          });
                                        },
                                        icon: const Icon(Icons.close))
                                  ],
                                ),
                                TextField(
                                  controller: controller,
                                  style: t14RegularBlack,
                                  cursorColor:
                                      Colors.blueAccent.withOpacity(0.4),
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
                                          color: Colors.blueAccent
                                              .withOpacity(0.4),
                                        )),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.4),
                                        )),
                                  ),
                                ),
                                kHeight15,
                                ElevatedButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          const WidgetStatePropertyAll(
                                              whiteColor),
                                      backgroundColor: WidgetStatePropertyAll(
                                          Colors.blueAccent.shade200),
                                      shape: WidgetStatePropertyAll(
                                          ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                  onPressed: () async {
                                    try {
                                      final newToken =
                                          await sharedPrefData.getToken();
                                      final redeemCode = controller.text;

                                      if (redeemCode.isEmpty) {
                                        log("empty string");
                                      } else {
                                        setState(() {
                                          _redeemClicked = true;
                                        });
                                        final response = await redeemService
                                            .postApaCode(redeemCode, newToken);

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
                                        } else if (response ==
                                            "APA Code Already Redeemed") {
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
                                        } else if (response ==
                                            "Invalid APA Code") {
                                          awesomeTopSnackbar(
                                            backgroundColor: Colors.red,
                                            textStyle: t18RegularWhite,
                                            context,
                                            "Invalid APA Code",
                                          );
                                        } else if (response ==
                                            "Incomplete User Profile") {
                                          awesomeTopSnackbar(
                                            backgroundColor: Colors.red,
                                            textStyle: t18RegularWhite,
                                            context,
                                            "Incomplete User Profile",
                                          );
                                        } else if (response ==
                                            "Not logged in") {
                                          log("not logged in");
                                          awesomeTopSnackbar(
                                            backgroundColor: Colors.red,
                                            textStyle: t18RegularWhite,
                                            context,
                                            "Not logged in",
                                          );
                                        } else if (response ==
                                            "Network Error") {
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
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                kHeight20,
                if (redeemOverlaySelected == false)
                  _currentShape == BoxShape.rectangle
                      ? IconButton(
                          style: const ButtonStyle(
                              elevation: WidgetStatePropertyAll(5),
                              enableFeedback: true,
                              shadowColor: WidgetStatePropertyAll(blackColor),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.white)),
                          onPressed: () async {
                            if (redeemOverlaySelected == false) {
                              await FlutterOverlayWindow.resizeOverlay(
                                WindowSize.matchParent,
                                800,
                                true,
                              );

                              setState(() {
                                redeemOverlaySelected = true;
                              });

                              await FlutterOverlayWindow.moveOverlay(
                                  const OverlayPosition(0, 0));
                            } else {
                              await FlutterOverlayWindow.resizeOverlay(
                                // deviceWidth.toInt(),
                                // 200,
                                WindowSize.matchParent,
                                800,
                                // (WindowSize.matchParent * 0.7).toInt(),
                                true,
                              );

                              setState(() {
                                redeemOverlaySelected = false;
                              });
                              await FlutterOverlayWindow.moveOverlay(
                                  OverlayPosition(0, 0));
                            }
                          },
                          icon: const Icon(
                            Icons.attach_money,
                            color: Colors.black,
                          ))
                      : const SizedBox.shrink(),
                if (redeemOverlaySelected == false)
                  _currentShape == BoxShape.rectangle
                      ? IconButton(
                          style: const ButtonStyle(
                              elevation: WidgetStatePropertyAll(5),
                              enableFeedback: true,
                              shadowColor: WidgetStatePropertyAll(blackColor),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.white)),
                          onPressed: () async {
                            BgLauncher.bringAppToForeground(
                              action: 'FBI-OPEN-UP',
                              extras: 'https://youtu.be/dQw4w9WgXcQ',
                            );
                            Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                homePort ??= IsolateNameServer.lookupPortByName(
                                  _kPortNameHome,
                                );
                                homePort?.send('Dollar');
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.home,
                            color: Colors.black,
                          ))
                      : const SizedBox.shrink(),
                if (redeemOverlaySelected == false)
                  _currentShape == BoxShape.rectangle
                      ? IconButton(
                          style: const ButtonStyle(
                            elevation: WidgetStatePropertyAll(5),
                            enableFeedback: true,
                            shadowColor: WidgetStatePropertyAll(blackColor),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                          ),
                          onPressed: () async {
                            BgLauncher.bringAppToForeground(
                              action: 'FBI-OPEN-UP',
                              extras: 'https://youtu.be/dQw4w9WgXcQ',
                            );
                            Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                homePort ??= IsolateNameServer.lookupPortByName(
                                  _kPortNameHome,
                                );
                                homePort?.send('Ads');
                              },
                            );
                          },
                          icon: const Icon(
                            CupertinoIcons.speaker_zzz_fill,
                            color: Colors.black,
                          ),
                        )
                      : const SizedBox.shrink(),
                if (redeemOverlaySelected == false)
                  _currentShape == BoxShape.rectangle
                      ? IconButton(
                          style: const ButtonStyle(
                            elevation: WidgetStatePropertyAll(5),
                            enableFeedback: true,
                            shadowColor: WidgetStatePropertyAll(blackColor),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                          ),
                          onPressed: () async {
                            BgLauncher.bringAppToForeground(
                              action: 'FBI-OPEN-UP',
                              extras: 'https://youtu.be/dQw4w9WgXcQ',
                            );
                            Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                FlutterOverlayWindow.closeOverlay();
                              },
                            );
                          },
                          icon: const Icon(
                            CupertinoIcons.multiply_circle,
                            color: Colors.black,
                          ))
                      : const SizedBox.shrink(),
                _currentShape == BoxShape.rectangle
                    ? const SizedBox(
                        height: 5,
                      )
                    : const SizedBox.shrink(),
                _currentShape == BoxShape.rectangle
                    ? Padding(
                        padding: redeemOverlaySelected == true
                            ? const EdgeInsets.all(8.0)
                            : EdgeInsets.zero,
                        child: Row(
                          mainAxisAlignment: redeemOverlaySelected == true
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: whiteColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0.3,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child:
                                        Image.asset("assets/icons/bg-logo.png"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                              spreadRadius: 0.3,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset("assets/icons/bg-logo.png"),
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
