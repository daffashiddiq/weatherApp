// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
  Province({
    required this.id,
    required this.nama,
  });

  int id;
  String nama;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
    id: json["id"],
    nama: json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
  };

  @override
  String toString() => nama;
}
