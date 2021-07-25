import 'package:flutter/material.dart';
import 'package:newsapp/shared_ui/naigation_drawer.dart';
import 'Hometabs/favorites.dart';
import 'Hometabs/popular.dart';


class HeadlineNews extends StatefulWidget {
  @override
  _HeadlineNewsState createState() => _HeadlineNewsState();
}

class _HeadlineNewsState extends State<HeadlineNews>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Headline News'),
        centerTitle: false,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
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
              icon: Icon(Icons.ac_unit),
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
            Favorites(),
            Popular(),
            Favorites(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
