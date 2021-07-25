import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isLoggedIn() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isLoggedIn = false;
  sharedPreferences.setBool("isloggedin", isLoggedIn);
  if (isLoggedIn == null || isLoggedIn == false) {
    return false;
  }
  return true;
}


