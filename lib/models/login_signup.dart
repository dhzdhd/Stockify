import 'package:flutter/material.dart';

class LoginSignupModel extends ChangeNotifier {
  bool model = true;

  void toLogin() {
    model = true;
    notifyListeners();
  }

  void toSignUp() {
    model = false;
    notifyListeners();
  }
}
