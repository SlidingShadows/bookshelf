import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeToken(String? token) async {
  var preferences = await SharedPreferences.getInstance();
  if (token != null) {
    await preferences.setString('token', token);
  } else {
    await preferences.remove('token');
  }
}

Future<void> clearToken() async {
  var preferences = await SharedPreferences.getInstance();
  await preferences.remove('token');
}

Future<String?> loadToken() async {
  var preferences = await SharedPreferences.getInstance();
  return preferences.getString('token');
}