import 'dart:math';
import 'package:flutter/material.dart';
import 'package:newsapp/api/posts_api.dart';
import 'package:newsapp/screens/single_post.dart';
import 'package:newsapp/utilities/data_handls.dart';
import 'package:newsapp/models/post_data.dart';
//import 'package:newsapp/models/post.dart';

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

PostsAPI postsAPI = PostsAPI();
int count;

class _WhatsNewState extends State<WhatsNew> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _drawHeader(),
          _drawTopstories(),
          _drawRecentUpdate(),
        ],
      ),
    );
  }

  Widget _drawHeader() {
    TextStyle _headerTitle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );
    TextStyle _headerDescription = TextStyle(
      fontSize: 18,
    );

    return FutureBuilder(
      future: postsAPI.fetchPostsByCategoryID("1"),
      builder: (context, AsyncSnapshot snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.waiting:
            return loadingcircle();
            break;

          case ConnectionState.active:
            return loadingcircle();
            break;

          case ConnectionState.none:
            return erorrConnection();
            break;

          case ConnectionState.done:
            if (snapShot.hasError) {
              errorinsnap(snapShot.error);
            } else {
              List<Post> posts = snapShot.data;
              Random random = Random();
              int randomIndex = random.nextInt(posts.length);
              randomIndex > 0
                  ? randomIndex = 1
                  : randomIndex = random.nextInt(posts.length);
              Post post = posts[randomIndex];

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SinglePost(post);
                  }));
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 47, right: 47),
                        child: Text(
                          post.title,
                          style: _headerTitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 33, right: 33),
                        child: SizedBox(
                          height: 8,
                        ),
                      ),
                      Text(
                        post.content.substring(0, 100),
                        style: _headerDescription,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.27,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(post.featuredImage),
                    fit: BoxFit.cover,
                  )),
                ),
              );
            }
            break;
        }
        return erorrConnection();
      },
    );
  }

  Widget _drawTopstories() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: _drawSectionTitle('Top Stories'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: FutureBuilder(
                future: postsAPI.fetchPostsByCategoryID('1'),
                builder: (context, AsyncSnapshot snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      return loadingcircle();
                      break;
                    case ConnectionState.active:
                      return loadingcircle();
                      break;
                    case ConnectionState.done:
                      if (snapShot.hasError) {
                        return errorinsnap(snapShot.error);
                      } else if (snapShot.hasData) {
                        List<Post> posts = snapShot.data;
                        if (posts.length >= 3) {
                          Post post1 = snapShot.data[0];
                          Post post2 = snapShot.data[1];
                          Post post3 = snapShot.data[2];
                          return Column(
                            children: [
                              _drawSingleRow(post1),
                              _drawDivider(),
                              _drawSingleRow(post2),
                              _drawDivider(),
                              _drawSingleRow(post3),
                            ],
                          );
                        }
                      }
                      break;
                    case ConnectionState.none:
                      return erorrConnection();
                      break;
                  }
                  return erorrConnection();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawRecentUpdate() {
    List<Post> posts = [];
    return Padding(
      padding: EdgeInsets.all(8),
      child: FutureBuilder(
          future: postsAPI.fetchPostsByCategoryID('4'),
          builder: (context, AsyncSnapshot snapShot) {
            switch (snapShot.connectionState) {
              case ConnectionState.waiting:
                return loadingcircle();
                break;
              case ConnectionState.active:
                return loadingcircle();
                break;
              case ConnectionState.done:
                if (snapShot.hasError) {
                  return errorinsnap(snapShot.error);
                } else if (snapShot.hasData) {
                  posts = snapShot.data;
                  // print(posts.length);
                  if (posts.length >= 2) {
                    Post post1 = snapShot.data[(posts.length - 2)];
                    Post post2 = snapShot.data[(posts.length - 1)];
                    if (post1.featuredImage.contains("localhost") &&
                        post1.featuredImage.contains("localhost")) {
                      post1.featuredImage = post1.featuredImage
                          .replaceAll("localhost", "192.168.1.20:80");
                      post2.featuredImage = post2.featuredImage
                          .replaceAll("localhost", "192.168.1.20:80");
                    }

                    // change image domain server from localhost to your pc ip
                    // this make photo appear on image asset 

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, bottom: 8, top: 8),
                          child: _drawSectionTitle('Recent updates'),
                        ),
                        _drawRecentUpdateCard(Colors.deepOrange, post1),
                        _drawRecentUpdateCard(Colors.deepPurple, post2),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    );
                  }
                }
                break;
              case ConnectionState.none:
                return erorrConnection();
                break;
            }

            return postListstatus();
          }),
    );
  }

  Widget _drawDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade400,
    );
  }

  Widget _drawSingleRow(Post post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SinglePost(post);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: 110,
                height: 110,
                child: Image.network(
                  //"http://192.168.1.20:80/newsapi/public/images/1623575840-bg1.jpg",
                  post.featuredImage,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    post.title,
                    maxLines: 2,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.user.name == null
                              ? "ahmad"
                              : post.user.name),
                          SizedBox(
                            height: 17,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.timer,
                                size: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 2.5, left: 7),
                                child: Text(humanDatetime(post.dateWritten)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade800),
    );
  }

  Widget _drawRecentUpdateCard(Color color, Post post) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SinglePost(post);
          }));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(post.featuredImage), fit: BoxFit.cover),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 20),
              child: Container(
                  padding:
                      EdgeInsets.only(top: 4, bottom: 4, left: 24, right: 24),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'SPORTS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 24, top: 16, bottom: 2),
              child: Text(
                post.content,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 16, top: 8, bottom: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.grey,
                    size: 19,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    humanDatetime(post.dateWritten),
                    style: TextStyle(color: Colors.grey, fontSize: 17),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
