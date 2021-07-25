import 'package:flutter/material.dart';
import 'package:newsapp/screens/home_screen.dart';
import 'package:newsapp/screens/threedot_pages/sendpost.dart';
import 'package:newsapp/screens/twitter_feed.dart';
import 'package:newsapp/shared_ui/naigation_drawer.dart';

class InstaGramFeed extends StatefulWidget {
  @override
  _InstaGramFeedState createState() => _InstaGramFeedState();
}

class _InstaGramFeedState extends State<InstaGramFeed> {
  TextStyle _hashtagStyle = TextStyle(color: Colors.orange);

  int _currentIndex = 2;

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
        title: Text('Instagram Feeds'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _drawHeader(),
                  _drawTitle(),
                  _drawHashTags(),
                  _drawBody(),
                  _drawFooter(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  

  Widget _drawHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
                  'FRI, 17 may 2021 * 14.30',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
              color: Colors.grey.shade400,
            ),
            Transform.translate(
              offset: Offset(-12, 0),
              child: Text(
                '25',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _drawTitle() {
    return Padding(
        padding: EdgeInsets.only(bottom: 8, left: 16, right: 16),
        child: Text(
          'We also talk about the future of work as robots',
          style: TextStyle(
            color: Colors.grey.shade900,
          ),
        ));
  }

  Widget _drawBody() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.30,
      child: Image(
        image: ExactAssetImage('assets/images/ph.jpg', scale: 1),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _drawFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
            onPressed: () {},
            child: Text(
              '10 COMMENTS',
              style: _hashtagStyle,
            )),
        Row(
          children: [
            FlatButton(
                onPressed: () {},
                child: Text(
                  'SHARE',
                  style: _hashtagStyle,
                )),
            FlatButton(
                onPressed: () {},
                child: Text(
                  'OPEN',
                  style: _hashtagStyle,
                )),
          ],
        )
      ],
    );
  }

  Widget _drawHashTags() {
    return Container(
      child: Wrap(
        children: [
          FlatButton(
              onPressed: () {},
              child: Text(
                '#advance',
                style: _hashtagStyle,
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                '#advance',
                style: _hashtagStyle,
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                '#advance',
                style: _hashtagStyle,
              )),
        ],
      ),
    );
  }
}
class BottomBarNav extends StatefulWidget {
  

  @override
  _BottomBarNavState createState() => _BottomBarNavState();
}

class _BottomBarNavState extends State<BottomBarNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
