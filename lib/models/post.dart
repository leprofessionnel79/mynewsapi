import 'package:newsapp/models/author.dart';
import 'package:newsapp/models/post_data.dart';

class Post {
  String id;
  String title;
  String content;
  String dateWritten;
  String featuredImage;
  String user_name;
  int votesUp;
  int votesDown;
  int userId;
  int categoryId;
  User user;

  Post({
    this.id,
    this.user_name,
    this.title,
    this.content,
    this.dateWritten,
    this.featuredImage,
    this.votesUp,
    this.votesDown,
    this.userId,
    this.categoryId,
    this.user
  });
}
