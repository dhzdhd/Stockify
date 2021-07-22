import 'package:flutter/cupertino.dart';
import 'package:supabase/supabase.dart';

class ProfileModel extends ChangeNotifier {
  User? profileUser;

  void update({required User? user}) {
    profileUser = user;
    notifyListeners();
  }
}
