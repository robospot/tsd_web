import 'dart:convert';

import 'package:tsd_web/models/company.dart';

class User {
  int id;
  String username;
  String name;
  Company vendororg;
  int vendororgid;
  String email;
  String password;
  String createdAt;
  String updatedAt;
  User({
    this.id,
    this.username,
    this.name,
    this.vendororg,
    this.vendororgid,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int id,
    String username,
    String name,
    Company vendororg,
    String email,
    String password,
    String createdAt,
    String updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      vendororg: vendororg ?? this.vendororg,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      // 'vendororg': vendororg?.toMap(),
      'vendororg': {"id": vendororg?.id},
      'email': email,
      'password': password,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return User(
      id: map['id'],
      username: map['username'],
      name: map['name'],
      vendororg: map['vendororg'] != null ? Company.fromMap(map['vendororg']) : null,
      email: map['email'],
      password: map['password'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(var source) => User.fromMap(source);

  @override
  String toString() {
    return 'User(id: $id, username: $username, name: $name, vendororg: $vendororg, email: $email, password: $password, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.id == id &&
        o.username == username &&
        o.name == name &&
        o.vendororg == vendororg &&
        o.email == email &&
        o.password == password &&
        o.createdAt == createdAt &&
        o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        name.hashCode ^
        vendororg.hashCode ^
        email.hashCode ^
        password.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
