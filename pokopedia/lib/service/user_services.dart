import 'dart:convert';
import 'package:http/http.dart';
import '../models/user.dart';

class UserService {
  Future<dynamic> login(String username, String password) async {
    try {
      Response response = await post(
          Uri.parse("http://10.0.2.2:3000/users/login"),
          body: {"username": username, "password": password});
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final data = json["data"];
        final result = {
          "access_token": data["access_token"].toString(),
          "userInfo": User(
            id: 0,
            username: data["userInfo"]["username"],
            email: data["userInfo"]["email"],
            password: '',
            fullname: data["userInfo"]["fullname"],
            avatar: data["userInfo"]["avatar"],
            address: data["userInfo"]["address"],
          ),
        };
        return result;
      } else if (response.statusCode == 500) {
        return json;
      }
      throw "Error Login Service";
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> register(username, password, fullname, email, address) async {
    try {
      Response response =
          await post(Uri.parse("http://10.0.2.2:3000/users/register"), body: {
        "username": username,
        "email": email,
        "password": password,
        "fullname": fullname,
        "address": address,
      });
      final json = jsonDecode(response.body);
      return json;
    } catch (e) {
      throw "Error Register Service $e";
    }
  }
}
