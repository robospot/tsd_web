import 'dart:async';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'auth_dio.dart';
import '../constants.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    var oauth = OAuth(
        clientId: "com.tsd", tokenUrl: '${ConfigStorage.baseUrl}auth/token');

    var token = await oauth
        .requestToken(PasswordGrant(username: username, password: password));
    print('AccessToken from request: ${token.accessToken}');

    var authenticadedDio = Dio();
    authenticadedDio.interceptors.add(BearerInterceptor(oauth));

    authenticadedDio.get('${ConfigStorage.baseUrl}me').then((response) {
      print(response.data);
    });

    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() async {
    await OAuthMemoryStorage().clear();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
