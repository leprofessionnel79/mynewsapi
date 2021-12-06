import 'package:flutter/material.dart';
import 'package:newsapp/models/post_data.dart';
import 'package:newsapp/screens/search.dart';
import 'package:newsapp/screens/single_post.dart';
import 'package:newsapp/utilities/data_handls.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> with AutomaticKeepAliveClientMixin {
  @override
  void dispose() {
   

    refreshController.dispose();

    super.dispose();
  }

  List<Post> posts = [];
  int currentPage = 1;

  int totalPages;

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getPostData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage > totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    final Uri uri = Uri.parse(
        "https://newsapi77.000webhostapp.com/api/posts/categories/1?page=$currentPage");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = postsdataFromJson(response.body);

      if (isRefresh) {
        posts = result.data;
      } else {
        posts.addAll(result.data);
      }

      currentPage++;

      totalPages = result.meta.lastPage;

      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // return SmartRefresher(
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 23,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Search(posts: posts)));
                }),
          ],
        ),
        body: SmartRefresher(
            controller: refreshController,
            enablePullUp: true,
            onRefresh: () async {
              final result = await getPostData(isRefresh: true);
              if (result) {
                refreshController.refreshCompleted();
              } else {
                refreshController.refreshFailed();
              }
            },
            onLoading: () async {
              final result = await getPostData();
              if (result) {
                refreshController.loadComplete();
              } else {
                refreshController.loadFailed();
              }
            },
            child: ListView.builder(
              itemBuilder: (context, index) {
               
                return Card(
                  child: _drawSingleRow(posts[index]),
                );
              },
              itemCount: posts.length,
            )));
  }

  Widget _drawSingleRow(Post post) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SinglePost(post);
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 110,
              height: 110,
              child: Image(
                image: NetworkImage(post.featuredImage.contains("localhost")
                    ? post.featuredImage
                        .replaceAll("localhost", "192.168.1.20:80")
                    : post.featuredImage),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    maxLines: 2,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.user.name == null ? "ahmad" : post.user.name),
                      SizedBox(
                        height: 21,
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.timer),
                          Padding(
                            padding: const EdgeInsets.only(left: 7, top: 2.5),
                            child: Text(humanDatetime(post.dateWritten)),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  
  bool get wantKeepAlive => true;
}
