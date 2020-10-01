import 'dart:convert';

class Ean {
  String ean;
  String language;
  String description;
  String createdAt;
  String updatedAt;
  Ean({
    this.ean,
    this.language,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  Ean copyWith({
    String ean,
    String language,
    String description,
    DateTime createdAt,
    DateTime updatedAt,
  }) {
    return Ean(
      ean: ean ?? this.ean,
      language: language ?? this.language,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ean': ean,
      'language': language,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Ean.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Ean(
      ean: map['ean'],
      language: map['language'],
      description: map['description'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  //Fix
  factory Ean.fromJson(var source) => Ean.fromMap(source);

  
  @override
  String toString() {
    return 'Ean(ean: $ean, language: $language, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Ean &&
      o.ean == ean &&
      o.language == language &&
      o.description == description &&
      o.createdAt == createdAt &&
      o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return ean.hashCode ^
      language.hashCode ^
      description.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
