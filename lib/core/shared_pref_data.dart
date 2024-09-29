import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefData {
  // Set token
  void setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  // Get token
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token') ?? "";
    print("token in the pref is $token");
    return token;
  }

  // Clear Shared Pref
  Future<void> clearSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Clear all key-value pairs from SharedPreferences
    await prefs.clear();
  }
}
