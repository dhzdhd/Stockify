import 'package:firebase_core/firebase_core.dart';
import 'package:supabase/supabase.dart';
import 'package:stockify/constants.dart' as constants;

class Auth {
  String email;
  String password;

  static final supabaseClient =
      SupabaseClient(constants.supabaseUrl, constants.supabaseKey);

  Auth({required this.email, required this.password});

  Future<bool> signUp() async {
    final response = await supabaseClient.auth.signUp(email, password);
    if (response.error != null) {
      print(response.error?.message);
      return false;
    } else {
      final user = response.user;
      constants.user = user;
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
      constants.user = user;
      return true;
    }
  }

  static Future<bool> signOut() async {
    final response = await supabaseClient.auth.signOut();
    if (response.error != null) {
      print(response.error.toString());
      return false;
    } else {
      constants.user = null;
      return true;
    }
  }
}
