import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/author.dart';
//import 'package:newsapp/models/post.dart';
import 'package:newsapp/utilities/api_utilties.dart';
import 'package:newsapp/models/post_data.dart';
import 'comment_api.dart';

class PostsAPI {
  Future<List<Post>> fetchPostsByCategoryID(String id) async {
    String WhatsNewAPI = base_api + categories_api + id;
    List<Post> posts = [];

    var response = await http.get(WhatsNewAPI);

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      var data = jsondata["data"];
      

      for (var item in data) {
        Post post = new Post(
          id: item['id'],
          title: item['title'].toString(),
          content: item['content'].toString(),
          featuredImage: item['featured_image'].toString(),
          dateWritten: item['date_written'].toString(),
          votesUp: item['votes_up'],
          votesDown: item['votes_down'],
          userId: item['user_id'],       
          categoryId: item['category_id'],
          user: User.fromJson(item['user']),
        );
        
        
        posts.add(post);
      }
    }
    
    return posts;
  }

  Future sendpost(String title, String content, String category_id,
      String token, String filepath) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type':
          'multipart/form-data; boundary=<calculated when request is sent>',
      'Authorization': 'Bearer ' + token
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(base_api + sendpost_api));
    request.fields.addAll(
        {'title': title, 'content': content, 'category_id': category_id});
    request.files
        .add(await http.MultipartFile.fromPath('featured_image', filepath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future sendcomment(String content, String post_id, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type':
          'multipart/form-data; boundary=<calculated when request is sent>',
      'Authorization': 'Bearer ' + token
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(base_api + sendcomment_api + post_id));
    request.fields.addAll({'content': content, 'post_id': post_id});
    // request.files
    //     .add(await http.MultipartFile.fromPath('featured_image', filepath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<List<Comment>> fetchCommentsByPostID(String id) async {
    List<Comment> comments = [];
    String PostCommentAPI = base_api + comments_api + id;

    var response = await http.get(PostCommentAPI);

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      var data = jsondata["data"];

      for (var item in data) {
        Comment comment = new Comment(
            id: item['id'].toString(),
            content: item['content'].toString(),
            dateWritten: item['date_written'].toString(),
            userId: item['user_id'],
            user_name: item['user_name'],
            postId: item['post_id'],
            author: Author.fromJson(item['user']));

        comments.add(comment);
      }
    }
    return comments;
  }
}
