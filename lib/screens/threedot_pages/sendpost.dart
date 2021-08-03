import 'dart:io';
import 'package:newsapp/shared_ui/naigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/api/posts_api.dart';
import 'package:newsapp/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendPost extends StatefulWidget {
  @override
  _SendPostState createState() => _SendPostState();
}

class _SendPostState extends State<SendPost> {
  bool isLoading = false;
  bool loginerror = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _contentController;
  TextEditingController _category_idController;

  String title;
  String content;
  String category_id;

  File _image;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _category_idController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _category_idController.dispose();
    super.dispose();
  }

  int _currentIndex = 0;

  PostsAPI postsAPI = PostsAPI();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Send Post"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: (isLoading) ? _drawLoading() : _drawLoginForm(),
            )));
  }

  Widget _drawLoginForm() {
    if (loginerror) {
      return Container(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(" login Error"),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  loginerror = false;
                });
              },
              child: Text(
                "Try Again",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        )),
      );
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Post title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Post Title';
              }
              return null;
            },
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: _contentController,
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Content'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Post Content';
              }
              return null;
            },
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: _category_idController,
            decoration: InputDecoration(labelText: 'Categoryid'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Post Categoryid';
              }
              return null;
            },
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: _image == null ? null : FileImage(_image),
                    radius: 80,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                      onTap: _pickImage, child: Icon(Icons.camera_alt))
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.red[800],
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  title = _titleController.text;
                  content = _contentController.text;
                  category_id = _category_idController.text;
                  sharedPreferences = await SharedPreferences.getInstance();
                  token = sharedPreferences.get("token");

                  var response = await postsAPI.sendpost(
                      title, content, category_id, token, _image.path);
                  print(response);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                }
                setState(() {
                  isLoading = false;
                });
              },
              child: Text(
                "SendPost",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
}
