import 'package:flutter/material.dart';
import 'package:newsapp/screens/home_screen.dart';
import 'package:newsapp/screens/instagram_feed.dart';
import 'package:newsapp/screens/threedot_pages/sendpost.dart';
import 'package:newsapp/shared_ui/naigation_drawer.dart';

class TwitterFeed extends StatefulWidget {
  @override
  _TwitterFeedState createState() => _TwitterFeedState();
}

class _TwitterFeedState extends State<TwitterFeed> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _currentIndex,
      //   backgroundColor: Colors.white,
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });

      //     switch (_currentIndex) {
      //       case 0:
      //          Navigator.push(
      //             context, MaterialPageRoute(builder: (context) => HomeScreen()));
      //         break;
      //       case 1:
      //          Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => TwitterFeed()));
      //         break;

      //       case 2:
      //          Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => InstaGramFeed()));
      //         break;
      //     }
      //   },
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: "Home",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: "Twitter",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.logout),
      //       label: "Instagram",
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        title: Text('Twitter Feeds'),
        centerTitle: false,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Card(
              child: Column(
                children: [
                  _CardHeader(),
                  _CardBody(),
                  _drawLine(),
                  _CardFooter(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _CardHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CircleAvatar(
            backgroundImage: ExactAssetImage(
              'assets/images/ph.jpg',
            ),
            radius: 24,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Christian Mayers',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  '@ch_mayer',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'FRI, 17 may 2021 * 14.30',
              style: TextStyle(color: Colors.grey),
            )
          ],
        )
      ],
    );
  }

  Widget _CardBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Text(
        'struggle to add the path to each image asset, instead just specify the path to your images directory. ... So I had to detail each folder and each sub-folder that contains assets',
        style: TextStyle(fontSize: 15, height: 1.3),
      ),
    );
  }

  Widget _CardFooter() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.repeat,
                  size: 27,
                ),
                color: Colors.orange,
                onPressed: () {},
              ),
              Text(
                '25',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              FlatButton(
                  onPressed: () {},
                  child: Text(
                    'SHARE',
                    style: TextStyle(color: Colors.orange),
                  )),
              FlatButton(
                  onPressed: () {},
                  child: Text(
                    'OPEN',
                    style: TextStyle(color: Colors.orange),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget _drawLine() {
    return Container(
      height: 1,
      color: Colors.grey.shade200,
      margin: EdgeInsets.only(top: 16),
    );
  }
}
