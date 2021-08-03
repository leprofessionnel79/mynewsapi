import 'package:flutter/material.dart';
import 'package:newsapp/screens/Hometabs/favorites.dart';
import 'package:newsapp/screens/Hometabs/whatsnew.dart';
import 'package:newsapp/screens/instagram_feed.dart';
import 'package:newsapp/screens/twitter_feed.dart';
import 'package:newsapp/shared_ui/naigation_drawer.dart';
import 'Hometabs/popular.dart';
import "threedot_pages/about.dart";
import "threedot_pages/contact.dart";
import "threedot_pages/help.dart";
import "threedot_pages/settings.dart";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum PopOutMenu { HELP, ABOUT, CONTACT, SETTINGS }

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //postsAPI.fetchPostsByCategoryID('4');

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore'),
        centerTitle: false,
        actions: [
          _PopUPm(context),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "WHATS NEW",
              icon: Icon(Icons.ac_unit),
            ),
            Tab(
              text: "POPULAR",
              icon: Icon(
                Icons.ac_unit,
              ),
            ),
            Tab(
              text: "FAVORITES",
              icon: Icon(Icons.ac_unit),
            ),
          ],
          controller: _tabController,
        ),
      ),
      
      drawer: NavigationDrawer(),
      body: Center(
        child: TabBarView(
          children: [
            WhatsNew(),
            Popular(),
            Favorites(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  Widget _PopUPm(BuildContext context) {
    return PopupMenuButton<PopOutMenu>(
      itemBuilder: (context) {
        return [
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.ABOUT,
            child: Text('ABOUT'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.CONTACT,
            child: Text('CONTACT'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.SETTINGS,
            child: Text('SETTINGS'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.HELP,
            child: Text('HELP'),
          ),
        ];
      },
      onSelected: (PopOutMenu menu) {
        switch (menu) {
          case PopOutMenu.ABOUT:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AboutPage();
            }));

            break;

          case PopOutMenu.CONTACT:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ContactPage();
            }));

            break;

          case PopOutMenu.HELP:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HelpPage();
            }));

            break;

          case PopOutMenu.SETTINGS:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SettingsPage();
            }));

            break;
        }
      },
      icon: Icon(Icons.more_vert),
    );
  }

  Widget _drawBottomNav(int _currentIndex) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      backgroundColor: Colors.white,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        switch (_currentIndex) {
          case 0:
            return Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
            break;
          case 1:
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) => TwitterFeed()));
            break;

          case 2:
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) => InstaGramFeed()));
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Twitter",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: "Instagram",
        ),
      ],
    );
  }
}
//remove unused class 
// class BottomNavBar extends StatefulWidget {
//   @override
//   _BottomNavBarState createState() => _BottomNavBarState();
// }

// class _BottomNavBarState extends State<BottomNavBar>
//     with SingleTickerProviderStateMixin {
//   TabController _controller;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose

//     super.dispose();
//     _controller.dispose();
//   }

//   int _currentIndex = 0;
//   final tabs = [
//     HomeScreen(),
//     TwitterFeed(),
//     InstaGramFeed()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: tabs[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _currentIndex,
//         backgroundColor: Colors.white,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });

//           switch (_currentIndex) {
//             case 0:
//               return Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => HomeScreen()));
//               break;
//             case 1:
//               return Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => TwitterFeed()));
//               break;

//             case 2:
//               return Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => InstaGramFeed()));
//               break;
//           }
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: "Twitter",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.logout),
//             label: "Instagram",
//           ),
//         ],
//       ),
//     );
//   }
// }
