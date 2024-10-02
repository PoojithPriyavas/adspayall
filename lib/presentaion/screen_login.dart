import 'dart:developer';
import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/constants.dart';
import 'package:ads_pay_all/core/shared_pref_data.dart';
import 'package:ads_pay_all/core/strings.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:ads_pay_all/presentaion/GradientBackground.dart';
import 'package:ads_pay_all/presentaion/screen_forget_password.dart';
import 'package:ads_pay_all/presentaion/screen_home.dart';
import 'package:ads_pay_all/presentaion/screen_sign_up.dart';
import 'package:ads_pay_all/provider/login_provider.dart';
import 'package:ads_pay_all/routes/routes.dart';
import 'package:ads_pay_all/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  bool isLoading = false;
  String? errorMessage;

  SharedPrefData sharedPrefData = SharedPrefData();

  @override
  void initState() {
    super.initState();

    getDateFromPref();
  }

  void getDateFromPref() async {
    final token = await sharedPrefData.getToken();
    if (token.isEmpty) {
      log("user not logged in");
    } else {
      StringConstants.TOKEN_STRING = token;
      NavigationHandler.navigateOff(context, ScreenHome());
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final loginProvider = Provider.of<LoginProvider>(context);
    final AuthService authService = AuthService();

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: GradientBackground(
          child: SizedBox(
            height: deviceHeight,
            width: deviceWidth,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "AdsPayAll",
                    style: t20SemiBoldWhite,
                  ),
                  kHeight20,
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                      ),
                      child: Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Your email/username",
                                style: t12MediumWhite,
                              ),
                              kHeight5,
                              CupertinoTextField(
                                placeholder: "Username",
                                controller: loginProvider.usernameController,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                cursorColor: greyColor,
                                style: t14RegularBlack,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color.fromARGB(
                                        255, 247, 247, 247),
                                    border: Border.all(
                                      color: lightGreyColor,
                                    )),
                              ),
                              kHeight20,
                              Text(
                                "Password",
                                style: t12MediumWhite,
                              ),
                              kHeight5,
                              CupertinoTextField(
                                suffix: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: lightGreyColor,
                                  ),
                                ),
                                // suffixIconColor: blueColor,,
                                placeholder: "Password",
                                controller: loginProvider.passwordController,

                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                cursorColor: greyColor,
                                style: t14RegularBlack,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color.fromARGB(
                                        255, 247, 247, 247),
                                    border: Border.all(
                                      color: lightGreyColor,
                                    )),
                              ),
                              kHeight15,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await loginProvider.clearSignUp();
                                      NavigationHandler.navigateTo(
                                          context, ScreenSignUp());
                                    },
                                    child: Text(
                                      "Create Account",
                                      style: t12MediumWhite,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => NavigationHandler.navigateTo(
                                        context, ScreenForgetPassword()),
                                    child: Text(
                                      "Forget Password?",
                                      style: t12MediumWhite,
                                    ),
                                  )
                                ],
                              ),
                              kHeight20,
                              SizedBox(
                                width: deviceWidth - 30,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          const WidgetStatePropertyAll(
                                              blueColor),
                                      shape: WidgetStatePropertyAll(
                                          ContinuousRectangleBorder(
                                              side:
                                                  BorderSide(color: whiteColor),
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                  onPressed: () async {
                                    try {
                                      final SharedPrefData sharedPrefData =
                                          SharedPrefData();
                                      setState(() {
                                        isLoading = true;
                                      });
                                      final username =
                                          loginProvider.usernameController.text;
                                      final password =
                                          loginProvider.passwordController.text;

                                      print('user name  in: $username');
                                      print('pass name  in: $password');

                                      final loginResponse = await authService
                                          .login(username, password);

                                      setState(() {
                                        isLoading = false;
                                      });

                                      if (loginResponse != null) {
                                        print(
                                            'Logged in: ${loginResponse.data.name}');
                                        print(
                                            'Token: ${loginResponse.data.token}');

                                        sharedPrefData
                                            .setToken(loginResponse.data.token);
                                        StringConstants.TOKEN_STRING =
                                            loginResponse.data.token;

                                        if (StringConstants
                                            .TOKEN_STRING.isNotEmpty) {
                                          Navigator.of(context).pushReplacement(
                                              CupertinoPageRoute(
                                            builder: (context) => ScreenHome(),
                                          ));
                                        }
                                      } else {
                                        print('Login failed');
                                      }
                                    } catch (e) {
                                      print("  e is $e");
                                    }
                                  },
                                  child: isLoading == true
                                      ? LoadingAnimationWidget
                                          .staggeredDotsWave(
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      : Text(
                                          "Log In",
                                          style: t16RegularWhite,
                                        ),
                                ),
                              )
                            ],
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
