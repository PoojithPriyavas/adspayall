import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool? _termsAndConditions = false;
  bool? get termsAndConditions => _termsAndConditions;

  // Sign up section

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();

  void choosedTermsAndConditions(bool? value) {
    _termsAndConditions = value;
    notifyListeners();
  }

  clearSignUp() {
    signupEmailController.clear();
    signupPasswordController.clear();
    signupConfirmPasswordController.clear();
  }

  // Forget Password section

  TextEditingController emailForgetPasswordControler = TextEditingController();
}
