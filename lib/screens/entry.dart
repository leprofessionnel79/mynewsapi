import 'package:flutter/material.dart';
import 'package:newsapp/screens/headline_news.dart';
import 'package:newsapp/screens/home_screen.dart';
import 'package:newsapp/screens/instagram_feed.dart';
import 'package:newsapp/screens/twitter_feed.dart';

class Entry extends StatefulWidget {
  

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  int _currentIndex=0;
  final tabs=[
    HomeScreen(),
    HeadlineNews(),
    TwitterFeed(),
    InstaGramFeed()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // switch (_currentIndex) {
          //   case 0:
          //     return Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => HomeScreen()));
          //     break;
          //   case 1:
          //     return Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => HeadNews()));
          //     break;

          //   case 2:
          //     return Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => TwitterFeed()));
          //     break;

          //    case 3:
          //     return Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => InstaGramFeed()));
          //     break;
          // }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "HeadNews",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Twitter",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Instagram",)
        ],
      )
    );
  }
}