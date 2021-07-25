import 'package:flutter/material.dart';
import 'package:newsapp/models/post_data.dart';

class Search extends StatefulWidget {
  final List<Post> posts;

  Search({@required this.posts});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Post> _searchedPost = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        appBar: AppBar(
          
          title: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: 'Search Post',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none),
            onChanged: (val) {
              setState(() {
                _searchedPost =
                    widget.posts.where((el) => el.title.contains(val)).toList();
              });
            },
          ),
        ),
        body: _searchedPost.isEmpty
            ? Center(
                child: Text(
                  'No match',
                  style: Theme.of(context).textTheme.headline3,
                ),
              )
            : ListView.builder(
                itemCount: _searchedPost.length,
                itemBuilder: (ctx, i) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(_searchedPost[i].title),
                        subtitle: Text(_searchedPost[i].content),
                      ),
                      Divider(
                        height: 0,
                      )
                    ],
                  );
                }));
  }
}
