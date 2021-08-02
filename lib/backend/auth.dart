import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart' as provider;
import 'package:supabase/supabase.dart';
import 'package:stockify/models/profile.dart';
import 'package:stockify/constants.dart' as constants;

class Auth {
  String email;
  String password;
  BuildContext context;

  static final supabaseClient =
      SupabaseClient(constants.supabaseUrl, constants.supabaseKey);

  Auth({required this.email, required this.password, required this.context});

  Future<bool> signUp() async {
    final response = await supabaseClient.auth.signUp(email, password);
    if (response.error != null) {
      print(response.error?.message);
      return false;
    } else {
      final user = response.user;
      provider.Provider.of<ProfileModel>(context, listen: false)
          .update(user: user);
      return true;
    }
  }

  Future<bool> signIn() async {
    final response =
        await supabaseClient.auth.signIn(email: email, password: password);
    if (response.error != null) {
      print(response.error?.message);
      return false;
    } else {
      final user = response.user;
      provider.Provider.of<ProfileModel>(context, listen: false)
          .update(user: user);
      return true;
    }
  }

  static Future<bool> signOut() async {
    final response = await supabaseClient.auth.signOut();
    if (response.error != null) {
      print(response.error.toString());
      return false;
    } else {
      ProfileModel().update(user: null);
      return true;
    }
  }
}
