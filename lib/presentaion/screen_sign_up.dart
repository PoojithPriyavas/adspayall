import 'package:ads_pay_all/core/colors.dart';
import 'package:ads_pay_all/core/constants.dart';
import 'package:ads_pay_all/core/style.dart';
import 'package:ads_pay_all/presentaion/GradientBackground.dart';
import 'package:ads_pay_all/presentaion/screen_login.dart';
import 'package:ads_pay_all/provider/login_provider.dart';
import 'package:ads_pay_all/routes/routes.dart';
import 'package:ads_pay_all/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final loginProvider = Provider.of<LoginProvider>(context);
    final AuthService authService = AuthService();

    return Scaffold(
      body: GradientBackground(
        child: SizedBox(
          height: deviceHeight,
          width: deviceWidth,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  kHeight20,
                  Text(
                    "Create New Account",
                    style: t24SemiBoldWhite,
                    textAlign: TextAlign.left,
                  ),
                  kHeight30,
                  Column(
                    children: [
                      Container(
                        // height: 350,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(255, 255, 255, 0.3),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              kHeight20,
                              Text(
                                "Your email/username",
                                style: t12MediumWhite,
                              ),
                              kHeight5,
                              CupertinoTextField(
                                controller: loginProvider.signupEmailController,
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
                                obscureText: true,
                                controller:
                                    loginProvider.signupPasswordController,
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
                                "Confirm Password",
                                style: t12MediumWhite,
                              ),
                              kHeight5,
                              CupertinoTextField(
                                obscureText: true,
                                controller: loginProvider
                                    .signupConfirmPasswordController,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    checkColor: whiteColor,
                                    activeColor: blueColor,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    side: const BorderSide(color: whiteColor),
                                    value: loginProvider.termsAndConditions,
                                    onChanged: (value) {
                                      print("selected");
                                      loginProvider
                                          .choosedTermsAndConditions(value);
                                    },
                                  ),
                                  kWidth5,
                                  Row(
                                    children: [
                                      Text(
                                        "I accept the ",
                                        style: t12MediumWhite,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "Terms and Conditions",
                                        style: t12SemiBoldWhite.copyWith(
                                            color: whiteColor),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              kHeight20,
                              SizedBox(
                                width: deviceWidth - 30,
                                height: 40,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      elevation:
                                          const WidgetStatePropertyAll(1),
                                      backgroundColor:
                                          const WidgetStatePropertyAll(
                                              blueColor),
                                      shape: WidgetStatePropertyAll(
                                          ContinuousRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                  onPressed: () async {
                                    try {
                                      final username = loginProvider
                                          .signupEmailController.text;
                                      final password = loginProvider
                                          .signupPasswordController.text;
                                      final confirmPassword = loginProvider
                                          .signupConfirmPasswordController.text;

                                      if (password.isEmpty ||
                                          confirmPassword.isEmpty ||
                                          username.isEmpty) {
                                        showCupertinoDialog(
                                            context: context,
                                            builder: (context) {
                                              return CupertinoAlertDialog(
                                                title: const Text(
                                                    'Check all fields'),
                                                content: const Text(
                                                    'All fields are required'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                                      } else if (password != confirmPassword) {
                                        print("password does not matches");

                                        showCupertinoDialog(
                                            context: context,
                                            builder: (context) {
                                              return CupertinoAlertDialog(
                                                title: const Text(
                                                    'Check Password'),
                                                content: const Text(
                                                    'Password does not match'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                                      } else if (loginProvider
                                              .termsAndConditions ==
                                          false) {
                                        showCupertinoDialog(
                                            context: context,
                                            builder: (context) {
                                              return CupertinoAlertDialog(
                                                title: const Text(
                                                    'Accept Terms and Conditions'),
                                                content: const Text(
                                                    'Password does not match'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
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
                                        final response = await authService
                                            .createAccount(username, password);

                                        print("response is the ther $response");
                                      }
                                    } catch (e) {
                                      print("eception is $e");
                                    }
                                  },
                                  child: Text(
                                    "Create account",
                                    style: t16RegularWhite,
                                  ),
                                ),
                              ),
                              kHeight20,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Already have an account? ",
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
                              kHeight20,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
