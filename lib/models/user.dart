import 'dart:convert';



class User {
  int id;
  String username;
  String name;
  String surname;
  String email;
  String password;
  String createdAt;
  String updatedAt;
  User({
    this.id,
    this.username,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });
  
 

  User copyWith({
    int id,
    String username,
    String name,
    String surname,
    String email,
    String password,
    String createdAt,
    String updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      surname: surname ?? this.surname,
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
      'surname': surname,
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
      surname: map['surname'],
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
    return 'User(id: $id, username: $username, name: $name, surname: $surname, email: $email, password: $password, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is User &&
      o.id == id &&
      o.username == username &&
      o.name == name &&
      o.surname == surname &&
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
      surname.hashCode ^
      email.hashCode ^
      password.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
