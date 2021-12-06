import 'package:newsapp/models/post_data.dart';


class Comment {
  String id;
  String content;
  String dateWritten;
  String create_at;
  String update_at;
  String user_name;
  int userId;
  int postId;
  User author;

  Comment({
    this.id,
    this.user_name,
    this.content,
    this.dateWritten,
    this.userId,
    this.postId,
    this.create_at,
    this.update_at,
    this.author,
  });
}
