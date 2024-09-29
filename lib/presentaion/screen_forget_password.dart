import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/constants.dart';
import 'package:ads_pay_all/core/shared_pref_data.dart';
import 'package:ads_pay_all/core/strings.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:ads_pay_all/presentaion/GradientBackground.dart';
import 'package:ads_pay_all/presentaion/screen_home.dart';
import 'package:ads_pay_all/presentaion/screen_login.dart';
import 'package:ads_pay_all/presentaion/screen_sign_up.dart';
import 'package:ads_pay_all/provider/login_provider.dart';
import 'package:ads_pay_all/routes/routes.dart';
import 'package:ads_pay_all/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ScreenForgetPassword extends StatefulWidget {
  const ScreenForgetPassword({super.key});

  @override
  State<ScreenForgetPassword> createState() => _ScreenForgetPasswordState();
}

class _ScreenForgetPasswordState extends State<ScreenForgetPassword> {
  bool isLoading = false;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final loginProvider = Provider.of<LoginProvider>(context);
    final AuthService authService = AuthService();

    return Scaffold(
      body: GradientBackground(
        child: Container(
          height: deviceHeight,
          width: deviceWidth,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                    ),
                    child: Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Forget your password?",
                              style: t20SemiBoldWhite,
                            ),
                            kHeight5,
                            Text(
                              "Don't fret! Just type in your email and we will send you a code to reset your password!",
                              style: t15RegularWhite,
                            ),
                            kHeight30,
                            Text(
                              "Your email/username",
                              style: t12MediumWhite,
                            ),
                            kHeight10,
                            CupertinoTextField(
                              placeholder: "Username",
                              controller:
                                  loginProvider.emailForgetPasswordControler,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              cursorColor: greyColor,
                              style: t14RegularBlack,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(255, 247, 247, 247),
                                  border: Border.all(
                                    color: lightGreyColor,
                                  )),
                            ),
                            kHeight15,
                            SizedBox(
                              width: deviceWidth - 30,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        const WidgetStatePropertyAll(blueColor),
                                    shape: WidgetStatePropertyAll(
                                        ContinuousRectangleBorder(
                                            side: const BorderSide(
                                                color: whiteColor),
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                                onPressed: () async {
                                  try {
                                    final email = loginProvider
                                        .emailForgetPasswordControler.text;

                                    if (email.isEmpty) {
                                      showCupertinoDialog(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoAlertDialog(
                                              title: const Text(
                                                  'Username/ Email Empty'),
                                              content: const Text(
                                                  'Username/ Email needed to continue'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'ok',
                                                    style: TextStyle(
                                                        color: blackColor),
                                                  ),
                                                )
                                              ],
                                            );
                                          });
                                    } else {
                                      authService.forgetPassword(
                                          email, context);
                                    }
                                  } catch (e) {
                                    print("execption is $e");
                                  }
                                },
                                child: isLoading == true
                                    ? LoadingAnimationWidget.staggeredDotsWave(
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    : Text(
                                        "Reset Password",
                                        style: t14SemiBoldWhite,
                                      ),
                              ),
                            ),
                            kHeight10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Remember the password?",
                                  style: t12MediumWhite,
                                  textAlign: TextAlign.center,
                                ),
                                GestureDetector(
                                  onTap: () => NavigationHandler.navigateOff(
                                      context, const ScreenLogin()),
                                  child: Text(
                                    " Login here",
                                    style: t12MediumWhite,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
