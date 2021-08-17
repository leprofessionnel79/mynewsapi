import 'package:flutter/material.dart';
import 'package:newsapp/api/posts_api.dart';
import 'package:newsapp/screens/showallcomments.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/models/post_data.dart';

class SinglePost extends StatefulWidget {
  final Post post;

  SinglePost(this.post);

  @override
  _SinglePostState createState() => _SinglePostState();
}

bool isLoading = false;
bool isLoggedIn = false;
String token;

SharedPreferences sharedPreferences;
String comment;
final GlobalKey<FormState> _formKeycomment = GlobalKey<FormState>();

class _SinglePostState extends State<SinglePost> {
  TextEditingController _commentController;
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

  @override
  void initState() {
   
    super.initState();
    _commentController = TextEditingController();
    _checkToken();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  PostsAPI postsAPI = PostsAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _drawPostImage(),
            _drawPostDetails(),
            isLoggedIn ? _commentsEntry() : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _drawPostDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            widget.post.content,
            style: TextStyle(fontSize: 18, letterSpacing: 1.2, height: 1.24),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 12, left: 16, bottom: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowAllComments(widget.post)));
            },
            child: Text(
              'SHOW COMMENTS !!',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _drawPostImage() {
    return Container(
     
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(widget.post.featuredImage.contains("localhost")?widget.post.featuredImage.replaceAll("localhost", "192.168.1.20:80"):widget.post.featuredImage), fit: BoxFit.cover),
      ),
    );
  }

  Widget _commentsEntry() {
    return Form(
      key: _formKeycomment,
      child: Container(
        color: Color.fromRGBO(241, 245, 247, 1),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: _commentController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your comment';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Entere comment here',
                      contentPadding:
                          EdgeInsets.only(left: 16, top: 24, bottom: 27),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      if (_formKeycomment.currentState.validate()) {
                        setState(() {
                          isLoading = true;
                          // myindex = 2;
                        });
                        comment = _commentController.text;
                        sharedPreferences =
                            await SharedPreferences.getInstance();
                        token = sharedPreferences.get("token");

                        var response = await postsAPI.sendcomment(
                            comment, widget.post.id.toString(), token);
                        print("response of sendcomment");
                        print(widget.post.id);
                        print(response);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowAllComments(widget.post)));
                        setState(() {
                          isLoading = false;
                        });
                        // _comments(comments[index]);
                        _commentController.clear();
                      }
                    },
                    child: Text(
                      'SEND',
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ),
            SizedBox(
              height: 7,
            )
          ],
        ),
      ),
    );
  }

  
}
