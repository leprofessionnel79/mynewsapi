import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/author.dart';
import 'package:newsapp/utilities/api_utilties.dart';

class AuthorAPI {
  Future<List<Author>> fetchAllAuthors() async {
    String AllAuthorAPI = base_api + all_authors_api;
    List<Author> authors = [];
    var response = await http.get(AllAuthorAPI);

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      var data = jsondata["data"];

      for (var item in data) {
        Author author = new Author(
            id: item['id'],
            name: item['name'].toString(),
            email: item['email'].toString(),
            avatar: item['avatar'].toString());

        authors.add(author);
      }
    }

    return authors;
  }

  Future<Author> fetchAuthorbyID(String id) async {
    String AuthorAPI = base_api + authors_api + id;
   // Author author;
    var response = await http.get(AuthorAPI);

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      var data = jsondata["data"];

      for (var item in data) {
        Author author = new Author(
            id: item['id'],
            name: item['name'].toString(),
            email: item['email'].toString(),
            avatar: item['avatar'].toString());

        return author;
      }
    }

   
  }
}
