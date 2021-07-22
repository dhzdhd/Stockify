import 'package:flutter/material.dart';

class LoginSignupModel extends ChangeNotifier {
  bool model = true;
  bool switchValue = false;

  void toLogin() {
    model = true;
    notifyListeners();
  }

  void toSignUp() {
    model = false;
    notifyListeners();
  }

  void changeSwitchValue(boolean) {
    switchValue = boolean;
    notifyListeners();
  }
}
