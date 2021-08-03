import 'package:flutter/material.dart';
import 'package:newsapp/api/comment_api.dart';
import 'package:newsapp/api/posts_api.dart';
import 'package:newsapp/utilities/data_handls.dart';
import 'package:newsapp/models/post_data.dart';


class ShowAllComments extends StatefulWidget {
  final Post post;

  ShowAllComments(this.post);
  
  
 

  @override
  _ShowAllCommentsState createState() => _ShowAllCommentsState();
}

class _ShowAllCommentsState extends State<ShowAllComments> {
   PostsAPI postsAPI = PostsAPI();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
      ),
      body: _drawFutureComment(),
    );
  }

  Widget _drawFutureComment() {
    return FutureBuilder(
      future: postsAPI.fetchCommentsByPostID(widget.post.id.toString()),
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
            List<Comment> comments = snapShot.data;
            return ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) =>
                    Card(child: _comments(comments[index])));
        }
        print("comment is empty");
        return commentListstatus();
      },
    );
  }

  Widget _comments(Comment comment) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            child: Column(children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(comment.author.avatar==null?'assets/images/ph.jpg':comment.author.avatar),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(comment.author.name == null
                          ? "ahmad"
                          : comment.author.name),
                      Text(humanDatetime(comment.dateWritten)),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(comment.content),
              SizedBox(
                height: 14,
              ),
            ]),
          )),
    );
  }
}
