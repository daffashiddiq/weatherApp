// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// // String apiKey = "a512fdfe47bec3d78badd68aa32788f2";
// // String kota = 'Jakarta';
// // String weatherApi = "api.openweathermap.org/data/2.5/forecast?q=$kota&appid=$apiKey";
//
// class getDataJson {
//
//   Future<WeatherModel> getWeather(String city) async {
//     var namaKota = removeFirstWord(city);
//
//     var response = await http.get(Uri.parse(
//         "https://api.openweathermap.org/data/2.5/forecast?q=$namaKota&appid=a512fdfe47bec3d78badd68aa32788f2"));
//
//     final json = jsonDecode(response.body);
//
//     return WeatherModel().fromJson(json);
//   }
//
//   String removeFirstWord(String namaKota){
//     var listKota = namaKota.split(" ");
//     if (listKota.length > 1) {
//       listKota = listKota.sublist(1,);
//       return listKota.join(" ");
//     }
//     return namaKota;
//   }
// }
// class ModelWeather {
//   ModelWeather(
//     // required this.cod,
//     // required this.message,
//     // required this.cnt,
//    this.list,this.city,
//   );
//
//   // String cod;
//   // int message;
//   // int cnt;
//   List<ListElement> list;
//   City city;
//
// }
//
// class City {
//   City({
//     required this.id,
//     required this.name,
//     required this.coord,
//     required this.country,
//     required this.population,
//     required this.timezone,
//     required this.sunrise,
//     required this.sunset,
//   });
//
//   int id;
//   String name;
//   Coord coord;
//   String country;
//   int population;
//   int timezone;
//   int sunrise;
//   int sunset;
// }
//
// class Coord {
//   Coord({
//     required this.lat,
//     required this.lon,
//   });
//
//   double lat;
//   double lon;
// }
//
// class ListElement {
//   ListElement({
//     required this.dt,
//     required this.main,
//     required this.weather,
//     required this.clouds,
//     required this.wind,
//     required this.visibility,
//     required this.pop,
//     required this.sys,
//     required this.dtTxt,
//     required this.rain,
//   });
//
//   int dt;
//   MainClass main;
//   List<Weather> weather;
//   Clouds clouds;
//   Wind wind;
//   int visibility;
//   double pop;
//   Sys sys;
//   DateTime dtTxt;
//   Rain rain;
// }
//
// class Clouds {
//   Clouds({
//     required this.all,
//   });
//
//   int all;
// }
//
// class MainClass {
//   MainClass({
//     required this.temp,
//     required this.feelsLike,
//     required this.tempMin,
//     required this.tempMax,
//     required this.pressure,
//     required this.seaLevel,
//     required this.grndLevel,
//     required this.humidity,
//     required this.tempKf,
//   });
//
//   double temp;
//   double feelsLike;
//   double tempMin;
//   double tempMax;
//   int pressure;
//   int seaLevel;
//   int grndLevel;
//   int humidity;
//   double tempKf;
// }
//
// class Rain {
//   Rain({
//     required this.the3H,
//   });
//
//   double the3H;
// }
//
// class Sys {
//   Sys({
//     required this.pod,
//   });
//
//   Pod pod;
// }
//
// enum Pod { D, N }
//
// class Weather {
//   Weather({
//     required this.id,
//     required this.main,
//     required this.description,
//     required this.icon,
//   });
//
//   int id;
//   MainEnum main;
//   Description description;
//   Icon icon;
// }
//
// enum Description { BROKEN_CLOUDS, LIGHT_RAIN, OVERCAST_CLOUDS, MODERATE_RAIN }
//
// enum Icon { THE_04_D, THE_04_N, THE_10_N, THE_10_D }
//
// enum MainEnum { CLOUDS, RAIN }
//
// class Wind {
//   Wind({
//     required this.speed,
//     required this.deg,
//     required this.gust,
//   });
//
//   double speed;
//   int deg;
//   double gust;
// }
