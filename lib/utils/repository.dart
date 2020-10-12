import 'dart:convert';

import 'package:tsd_web/models/company.dart';
import 'package:tsd_web/models/dm.dart';
import 'package:http/http.dart' as http;
import 'package:tsd_web/models/ean.dart';
import 'package:tsd_web/models/packList.dart';
import 'package:tsd_web/models/user.dart';
import 'package:tsd_web/utils/constants.dart';

abstract class Repository {
  /// Throws [NetworkException].
  Future<List<Dm>> fetchDm();
}

class DataRepository implements Repository {
  
  Future<List<Dm>> fetchDm() async {
    final http.Response response = await http.get('${ConfigStorage.baseUrl}dm');
    // headers: headers);
    if (response.statusCode == 200) {
      // List<Dm> dmList;
      var dmList = (json.decode(response.body) as List)
          .map((e) => Dm.fromJson(e))
          .toList();
      return dmList;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }

  Future<List<Ean>> fetchEan() async {
    final http.Response response = await http.get('${ConfigStorage.baseUrl}ean');
    // headers: headers);
    if (response.statusCode == 200) {
      // List<Dm> dmList;
      var eanList = (json.decode(response.body) as List)
          .map((e) => Ean.fromJson(e))
          .toList();
      return eanList;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }

  Future<List<PackList>> fetchPackList() async {
    final http.Response response = await http.get('${ConfigStorage.baseUrl}packlist');
    // headers: headers);
    if (response.statusCode == 200) {
      // List<Dm> dmList;
      var packList = (json.decode(response.body) as List)
          .map((e) => PackList.fromJson(e))
          .toList();
      return packList;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }


  Future<List<Company>> fetchCompany() async {
    final http.Response response =
        await http.get('${ConfigStorage.baseUrl}company');
    // headers: headers);
    if (response.statusCode == 200) {
      // List<Dm> dmList;
      var dmList = (json.decode(response.body) as List)
          .map((e) => Company.fromJson(e))
          .toList();
      print('companies fetched');
      return dmList;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }

Future<List<User>> fetchVendorUser() async {
    final http.Response response =
        await http.get('${ConfigStorage.baseUrl}user');
    // headers: headers);
    if (response.statusCode == 200) {
      // List<Dm> dmList;
      var vendorUserList = (json.decode(response.body) as List)
          .map((e) => User.fromJson(e))
          .toList();
      print('users fetched');
      return vendorUserList;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }


  Future<Company> addCompany(Company company) async {
    print('${company.toJson()}');
    var headers = {"Content-Type": "application/json"};
    final http.Response response = await http.post(
        '${ConfigStorage.baseUrl}company',
        body: company.toJson(),
        headers: headers);
    if (response.statusCode == 200) {
      Company data = Company.fromJson(json.decode(response.body));

      return data;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }

  Future<void> clearDmTable() async {
    var headers = {"Content-Type": "application/json"};
    final http.Response response =
        await http.delete('${ConfigStorage.baseUrl}dm', headers: headers);
    if (response.statusCode == 200) {
      return null;
    } else {
      print('Network connection error');
      NetworkException();
      return null;
    }
  }
}

class NetworkException implements Exception {}
