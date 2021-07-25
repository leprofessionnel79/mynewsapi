import 'package:flutter/material.dart';
import 'package:newsapp/models/nav_menu.dart';
import 'package:newsapp/screens/entry.dart';
import 'package:newsapp/screens/home_screen.dart';
import 'package:newsapp/screens/threedot_pages/regisetr.dart';
import 'package:newsapp/screens/threedot_pages/sendpost.dart';
import 'package:newsapp/screens/threedot_pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

bool isLoggedIn = false;
String token;

SharedPreferences sharedPreferences;

class _NavigationDrawerState extends State<NavigationDrawer> {
  List<NavMenuItem> navMenu = [
    
    NavMenuItem(title: 'Explore', destination: () => Entry()),
    
  ];

  _checkToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get("token");
    
    setState(() {
      if (token == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
    });
  }

  _logOut() {
    if (sharedPreferences != null) {
      sharedPreferences.remove("token");
    }
    return Entry();
  }

  @override
  void initState() {
    super.initState();
    if (isLoggedIn) {
      setState(() {
        navMenu.add(NavMenuItem(title: 'Logout', destination: () => _logOut()));
      navMenu
          .add(NavMenuItem(title: 'Send Post', destination: () => SendPost()));
      navMenu.remove(
        NavMenuItem(title: 'Login', destination: () => Login()),
      );
      navMenu.remove(
        NavMenuItem(title: 'Regist', destination: () => Register()),
      );
      });
      
    } else {
      setState(() {
         navMenu.add(NavMenuItem(title: 'Login', destination: () => Login()));
      navMenu.add(NavMenuItem(title: 'Regist', destination: () => Register()));
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.mounted) {
      _checkToken();
      
    }
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 75, left: 23),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => navMenu[index].destination()));
                },
                title: Text(
                  navMenu[index].title,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 21),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
              ),
            );
          },
          itemCount: navMenu.length,
        ),
      ),
    );
  }
}
