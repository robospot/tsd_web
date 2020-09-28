import 'dart:convert';

class Dm {
  int organization;
  String sscc;
  String ean;
  String datamatrix;
  bool isUsed;
  String createdAt;
  String updatedAt;
  Dm({
    this.organization,
    this.sscc,
    this.ean,
    this.datamatrix,
    this.isUsed,
    this.createdAt,
    this.updatedAt,
  });

  Dm copyWith({
    int organization,
    String sscc,
    String ean,
    String datamatrix,
    bool isUsed,
    String createdAt,
    String updatedAt,
  }) {
    return Dm(
      organization: organization ?? this.organization,
      sscc: sscc ?? this.sscc,
      ean: ean ?? this.ean,
      datamatrix: datamatrix ?? this.datamatrix,
      isUsed: isUsed ?? this.isUsed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'organization': organization,
      'sscc':sscc,
      'ean': ean,
      'datamatrix': datamatrix,
      'isUsed': isUsed,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Dm.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Dm(
      organization: map['organization'],
      sscc: map['sscc'],
      ean: map['ean'],
      datamatrix: map['datamatrix'],
      isUsed: map['isUsed'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Dm.fromJson(var source) => Dm.fromMap(source);

  @override
  String toString() {
    return 'Dm(organization: $organization, sscc: $sscc, ean: $ean, datamatrix: $datamatrix, isUsed: $isUsed, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Dm &&
        o.organization == organization &&
        o.sscc == sscc &&
        o.ean == ean &&
        o.datamatrix == datamatrix &&
        o.isUsed == isUsed &&
        o.createdAt == createdAt &&
        o.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return organization.hashCode ^
        ean.hashCode ^
        sscc.hashCode ^
        datamatrix.hashCode ^
        isUsed.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
