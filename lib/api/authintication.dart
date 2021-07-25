import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/post_data.dart';
import 'package:newsapp/utilities/api_utilties.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthinticationAPI {
  Future<bool> login(String email, String password) async {
    String authAPI = base_api + authintication_api;
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Map<String, String> body = {"email": email, "password": password};

    var response = await http.post(authAPI, headers: headers, body: body);

    if (response.statusCode == 200) {
      try {
        var jsondata = jsonDecode(response.body);
        var data = jsondata["data"];
        var token = data['Token'];
        var name = data['name'];

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        sharedPreferences.setString("name", name);
        return true;
      } catch (Exception) {
        return false;
      }
    }

    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    String authAPI = base_api + authintication_register_api;
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Map<String, String> body = {
      "name": name,
      "email": email,
      "password": password,
    };

    var response = await http.post(authAPI, headers: headers, body: body);

    if (response.statusCode == 200) {
      try {
        var jsondata = jsonDecode(response.body);
        var data = jsondata["data"];
        User.fromJson(data);

        // for (var item in data) {
        //   User user = User(
        //     name: item['name'],
        //     email: item['email'],
        //     apiToken: item['api_token'],
        //     updatedAt: item['updated_at'],
        //     createdAt: item['created_at'],
        //     id: item['id'],
        //   );
        // }
        // var token = data['Token'];
        // var name = data['name'];
        //User.fromJson(data);

        // SharedPreferences sharedPreferences =
        //     await SharedPreferences.getInstance();
        // sharedPreferences.setString("token", token);
        // sharedPreferences.setString("name", name);
        return true;
      } catch (Exception) {
        return false;
      }
    }
    
    return false;
  }
}
