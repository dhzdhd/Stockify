import 'package:flutter/material.dart';

class LoginSignupModel extends ChangeNotifier {
  var model = true;

  void toLogin() {
    model = true;
    notifyListeners();
  }

  void toSignUp() {
    model = false;
    notifyListeners();
  }
}
