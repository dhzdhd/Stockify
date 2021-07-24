import 'package:stockify/constants.dart' as constants;
import 'package:toml/toml.dart';

class LoginData {
  Future<TomlDocument> initToml() async {
    var document = await TomlDocument.load('user.toml');
    return document;
  }

  Future<bool> storeData(
      {required String email, required String password}) async {
    return true;
  }

  Future<void> fetchData() async {
    var document = initToml();
    print(document.toString());
  }

  Future<bool> deleteData() async {
    return true;
  }
}
