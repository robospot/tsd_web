import 'dart:async';
import 'package:dio/dio.dart';
import 'package:tsd_web/models/company.dart';
import 'package:tsd_web/models/user.dart';

import 'auth_dio.dart';
import '../constants.dart';

class UserRepository {
  User _user;

  Future<User> getUser() async {
    var oauth = OAuth(
        clientId: "com.tsd", tokenUrl: '${ConfigStorage.baseUrl}auth/token');
    var authenticadedDio = Dio();
    authenticadedDio.interceptors.add(BearerInterceptor(oauth));

    Response response =
        await authenticadedDio.get('${ConfigStorage.baseUrl}me');

    print(response.data);
    _user = User.fromJson(response.data);
    print(_user.name);
    if (_user != null)
      return _user;
    else
      return null;
  }

  Future<User> createUser({
    String email,
    String name,
    String username,
    String password,
    int vendororgid
  }) async {
    Response response;
    Dio dio = new Dio();
    User _user = User(
        name: name,
        email: email,
        password: password,
        username: username,
        vendororg: Company(id: vendororgid));
    print(_user.toJson());
    response = await dio.post(
      '${ConfigStorage.baseUrl}register',
      data: _user.toJson(),
    );
    print(response.data);
    _user = null;
    _user = User.fromJson(response.data);
    print(_user.name);
    return _user;
  }
}
