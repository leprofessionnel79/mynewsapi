import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/category.dart';
import 'package:newsapp/utilities/api_utilties.dart';

class CategoryAPI {
  Future<List<Category>> fetchAllAuthors() async {
    String AllCategoryAPI = base_api + all_categories_api;
    List<Category> categories = [];
    var response = await http.get(AllCategoryAPI);

    if (response.statusCode == 200) {
      var Jsondata = jsonDecode(response.body);
      var data = Jsondata["data"];

      for (var item in data) {
        Category category = new Category(
            id: item['id'].toString(), title: item['title'].toString());

        categories.add(category);
      }
    }

    return categories;
  }
}
