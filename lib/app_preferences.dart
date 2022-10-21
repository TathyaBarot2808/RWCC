import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const email = "email";
  static const password = "password";
  static const name = "name";
  static const age = "age";

  Future<String?> getPreferenceValue(String key) async {
    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                        return sharedPreferences.getString(key);          
  }

  Future<bool> setPreferenceValue(String key, String value) async {
    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                        return sharedPreferences.setString(key, value);          
  }
}