import 'package:shared_preferences/shared_preferences.dart';

final String isLogin = "isLogin";
String idUser;

Future getLogin() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getBool(isLogin) ?? false;
}

Future<bool> setLogin(String key, bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.setBool(key, value);
}

guardarToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = await prefs.getString("token");
  return token;
}

guardaridFirebase(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('idFirebase', id);
}

Future<String> getFirebaseId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final idFirebase = await prefs.get("idFirebase");
  idUser = idFirebase;
  return idFirebase;
}
