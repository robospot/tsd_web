import 'dart:async';
import 'dart:convert';

import 'package:tsd_web/models/user.dart';

class UserRepository {
  User _user;

  Future<User> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User('User'),
    );
  }

  Future<User> createUser() async {
       Future<int> createUser(String email, String name, String category,
      String username, String password, int owner) async {
    // token = await UserRepository().getToken();
    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token"
    };
    var body = {
      // "owner": owner,
      "email": email,
      "name": name,
      // "category": category,
      "username": username,
      "password": password,
    };
    final http.Response response = await http.post(
        '${ConfigStorage.baseUrl}register',
        headers: headers,
        body: json.encode(body));
    if (response.statusCode == 200) {
      User.fromJson(json.decode(response.body));

      return response.statusCode;
    } else {
      print('Network connection error');
      return response.statusCode;
    }
  }
     
     
     
     return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User('User'),
    );
  }
}
