import 'package:flutter/material.dart';
import 'package:newsapp/screens/entry.dart';
import 'package:newsapp/utilities/apptheme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/OnBoarding.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 Widget _screen;
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen');
   _screen = OnBoarding();
  if (seen == null || seen == false) {
    _screen = OnBoarding();
  } else {
    _screen = Entry();
  }

  //SharedPreferences.setMockInitialValues({});
  
  

   

  runApp(NewsApp(_screen));
}

class NewsApp extends StatelessWidget {
  final Widget _screen;

  NewsApp(this._screen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: _screen,
    );
  }
}
