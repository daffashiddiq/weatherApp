// To parse this JSON data, do
//
//     final city = cityFromJson(jsonString);

import 'dart:convert';

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    required this.id,
    required this.idProvinsi,
    required this.nama,
  });

  int id;
  String idProvinsi;
  String nama;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    idProvinsi: json["id_provinsi"],
    nama: json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_provinsi": idProvinsi,
    "nama": nama,
  };

  @override
  String toString() => nama;
}
