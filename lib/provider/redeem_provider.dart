import 'package:flutter/cupertino.dart';

class RedeemProvider extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();

  void clearController() {
    controller.clear();
    notifyListeners();
  }
}
