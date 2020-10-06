import 'dart:convert';

class PackList {
  int id;
  String packList;
  String sscc;
  String createdAt;
  String updatedAt;
  PackList({
    this.id,
    this.packList,
    this.sscc,
    this.createdAt,
    this.updatedAt,
  });

  PackList copyWith({
    int id,
    String packList,
    String sscc,
    String createdAt,
    String updatedAt,
  }) {
    return PackList(
      id: id ?? this.id,
      packList: packList ?? this.packList,
      sscc: sscc ?? this.sscc,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'packList': packList,
      'sscc': sscc,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory PackList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return PackList(
      id: map['id'],
      packList: map['packList'],
      sscc: map['sscc'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PackList.fromJson(var source) => PackList.fromMap(source);

  @override
  String toString() {
    return 'PackList(id: $id, packList: $packList, sscc: $sscc, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is PackList &&
      o.id == id &&
      o.packList == packList &&
      o.sscc == sscc &&
      o.createdAt == createdAt &&
      o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      packList.hashCode ^
      sscc.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
