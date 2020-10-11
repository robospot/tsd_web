// library oauth_dio;
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef OAuthToken OAuthTokenExtractor(Response response);
typedef Future<bool> OAuthTokenValidator(OAuthToken token);

/// Interceptor to send the bearer access token and update the access token when needed
class BearerInterceptor extends Interceptor {
  OAuth oauth;

  BearerInterceptor(this.oauth);

  /// Add Bearer token to Authorization Header
  @override
  Future onRequest(RequestOptions options) async {
    final token = await oauth.fetchOrRefreshAccessToken();
    if (token != null) {
      print('token from Bearer interceptor: ${token.accessToken}');
      //   options.contentType = 'application/x-www-form-urlencoded';
      // options.headers['content-type'] = 'application/x-www-form-urlencoded';
      options.headers['authorization'] = "Bearer ${token.accessToken}";
      // options.headers.addAll({"authorization": "Bearer ${token.accessToken}"});
    }
    return options;
  }
}

/// Use to implement a custom grantType
abstract class OAuthGrantType {
  RequestOptions handle(RequestOptions request);
}

/// Obtain an access token using a username and password
class PasswordGrant extends OAuthGrantType {
  String username;
  String password;
  List<String> scope = [];

  PasswordGrant({this.username, this.password, this.scope});

  /// Prepare Request
  @override
  RequestOptions handle(RequestOptions request) {
    request.data =
        "grant_type=password&username=${Uri.encodeComponent(username)}&password=${Uri.encodeComponent(password)}";
    return request;
  }
}

/// Obtain an access token using an refresh token
class RefreshTokenGrant extends OAuthGrantType {
  String refreshToken;

  RefreshTokenGrant({this.refreshToken});

  /// Prepare Request
  @override
  RequestOptions handle(RequestOptions request) {
    request.data = "grant_type=refresh_token&refresh_token=$refreshToken";
    return request;
  }
}

/// Use to implement custom token storage
abstract class OAuthStorage {
  final accessTokenKey = 'accessToken';
  final refreshTokenKey = 'refreshToken';

  /// Read token
  Future<OAuthToken> fetch();
 
  /// Save Token
  Future<OAuthToken> save(OAuthToken token);
 

  /// Clear token
  Future<void> clear(); 
  
}

/// Save Token in Memory
class OAuthMemoryStorage extends OAuthStorage {
  OAuthToken _token;

  /// Read
  @override
  Future<OAuthToken> fetch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return OAuthToken(
        accessToken: prefs.getString(accessTokenKey),
        refreshToken: prefs.getString(refreshTokenKey));
    // return _token;
  }

  /// Save
  @override
  Future<OAuthToken> save(OAuthToken token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('token to be saved: ${token.accessToken}');
    prefs.setString(accessTokenKey, token.accessToken);
    prefs.setString(refreshTokenKey, token.refreshToken);
    return token;
  }

  /// Clear
  Future<void> clear() async {
    _token = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(accessTokenKey);
    prefs.remove(refreshTokenKey);
  }
}

/// Token
class OAuthToken {
  String accessToken;
  String refreshToken;

  OAuthToken({this.accessToken, this.refreshToken});
}

/// Encode String To Base64
Codec<String, String> stringToBase64 = utf8.fuse(base64);

/// OAuth Client
class OAuth {
  Dio dio;
  String tokenUrl;
  String clientId;
  String clientSecret;
  OAuthStorage storage;
  OAuthTokenExtractor extractor;
  OAuthTokenValidator validator;

  OAuth(
      {this.tokenUrl,
      this.clientId,
      this.clientSecret,
      this.extractor,
      this.dio,
      this.storage,
      this.validator}) {
    dio = dio ?? Dio();
    storage = storage ?? OAuthMemoryStorage();
    extractor = extractor ??
        (res) => OAuthToken(
            accessToken: res.data['access_token'],
            refreshToken: res.data['refresh_token']);
    validator = validator ?? (token) => Future.value(true);
  }

  /// Request a new Access Token using a strategy
  Future<OAuthToken> requestToken(OAuthGrantType grantType) async {
    final String clientCredentials =
        const Base64Encoder().convert("$clientId:".codeUnits);
    final request = grantType.handle(RequestOptions(
        method: 'POST',
        contentType: 'application/x-www-form-urlencoded',
        headers: {
          "content-type": "application/x-www-form-urlencoded",
          "authorization": "Basic $clientCredentials"
        }));

//Added 11.10.2020 as Fix
    dio.options.contentType = 'application/x-www-form-urlencoded';
    dio.options.headers['content-type'] = 'application/x-www-form-urlencoded';
    dio.options.headers['authorization'] = "Basic $clientCredentials";

    var r = await dio.post(tokenUrl, data: request.data);
    var token = extractor(r);
    var q = await storage.save(token);
    return q;
   
  }

  /// return current access token or refresh
  Future<OAuthToken> fetchOrRefreshAccessToken() async {
    OAuthToken token = await storage.fetch();

    if (token.accessToken == null) {
      return null;
    }

    if (await this.validator(token)) return token;

    return this.refreshAccessToken();
  }

  /// Refresh Access Token
  Future<OAuthToken> refreshAccessToken() async {
    OAuthToken token = await storage.fetch();

    return this
        .requestToken(RefreshTokenGrant(refreshToken: token.refreshToken));
  }
}
