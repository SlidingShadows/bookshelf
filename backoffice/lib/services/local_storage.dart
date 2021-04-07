import 'package:shared_preferences/shared_preferences.dart';

void storeToken(String token) async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", token);
}

Future<String?> loadToken() async {
  var prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}