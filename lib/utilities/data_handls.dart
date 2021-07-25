import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeAgo;

Widget loadingcircle() {
  return Container(
    child: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.shade500),
      ),
    ),
  );
}



Widget erorrConnection() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Center(
      child: Text(' Error Connection !!!'),
    ),
  );
}

Widget postListstatus() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Center(
      child: Text('Post List is empty'),
    ),
  );
}

Widget commentListstatus() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Center(
      child: Text('Comments List is empty'),
    ),
  );
}

Widget errorinsnap(var error) {
  return Container(
    padding: EdgeInsets.all(16),
    child: Center(
      child: Text(error.toString()),
    ),
  );
}

String humanDatetime(String datetime) {
  Duration timeago = DateTime.now().difference(DateTime.parse(datetime));
  DateTime thedifrence = DateTime.now().subtract(timeago);
  return timeAgo.format(thedifrence);
}
