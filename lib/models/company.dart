import 'dart:convert';

class Company {
  int id;
  String shortName;
  String fullName;
  DateTime createdAt;
  DateTime updatedAt;

  Company({
    this.id,
    this.shortName,
    this.fullName,
    this.createdAt,
    this.updatedAt,
  });

  Company copyWith({
    int id,
    String shortName,
    String fullName,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return Company(
      id: id ?? this.id,
      shortName: shortName ?? this.shortName,
      fullName: fullName ?? this.fullName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shortName': shortName,
      'fullName': fullName,
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Company(
      id: map['id'],
      shortName: map['shortName'],
      fullName: map['fullName'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

//fixed here
  factory Company.fromJson(var source) => Company.fromMap(source);

  @override
  String toString() {
    return 'Company(id: $id, shortName: $shortName, fullName: $fullName, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Company &&
        o.id == id &&
        o.shortName == shortName &&
        o.fullName == fullName &&
        o.createdAt == createdAt &&
        o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        shortName.hashCode ^
        fullName.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
