import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String apiKey = "a512fdfe47bec3d78badd68aa32788f2";
String kota = 'Jakarta';
String weatherApi = "api.openweathermap.org/data/2.5/forecast?q=$kota&appid=$apiKey";

class getDataJson {

  Future<WeatherModel> getWeather(String city) async {
    var namaKota = removeFirstWord(city);

    var response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$namaKota&appid=a512fdfe47bec3d78badd68aa32788f2&units=metric"));

    // if (response.statusCode == 200){
    //   final json = jsonDecode(response.body);
    //
    // }

    final json = jsonDecode(response.body);

    final weatherTest = WeatherModel.fromJson(json);

    return WeatherModel.fromJson(json);
  }

  String removeFirstWord(String namaKota){
    var listKota = namaKota.split(" ");
    if (listKota.length > 1) {
      listKota = listKota.sublist(1,);
      return listKota.join(" ");
    }
    return namaKota;
  }
}

class WeatherModel {
  final List<ListElement> list;
  final CityName city;

  WeatherModel({
    required this.list,
    required this.city,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final list = json['list'] as List;
    List<ListElement> weatherList = list.map((i) => ListElement.fromJson(i)).toList();
    final city = CityName.fromJson(json['city']);

    return WeatherModel(list: weatherList, city: city);
  }

}

class CityName {
  CityName({
    required this.name,
    required this.country,
  });

  String name;
  String country;

  factory CityName.fromJson(Map<String, dynamic> json){
    final name = json['name'];
    final country = json['country'];

    return CityName(name: name, country: country);
  }

}

// class Coord {
//   Coord({
//     required this.lat,
//     required this.lon,
//   });
//
//   double lat;
//   double lon;
//
//   factory Coord.fromJson(Map<String, dynamic> json) => Coord(
//     lat: json["lat"].toDouble(),
//     lon: json["lon"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "lat": lat,
//     "lon": lon,
//   };
// }

class ListElement {
  ListElement({
    required this.dt,
    required this.main,
    required this.weather,
    required this.wind,
    required this.clouds,
    required this.visibility,
    required this.dtTxt,
  });

  int dt;
  MainClass main;
  Weather weather;
  Wind wind;
  Clouds clouds;
  int visibility;
  DateTime dtTxt;

  factory ListElement.fromJson(Map<String, dynamic> json) {
    final dt = json["dt"];
    final main = MainClass.fromJson(json["main"]);
    final weather = json['weather'][0];
    final weatherDetails = Weather.fromJson(weather);
    final wind = Wind.fromJson(json['wind']);
    final clouds = Clouds.fromJson(json["clouds"]);
    final visibility = json["visibility"];
    final dtTxt = DateTime.parse(json["dt_txt"]);
    
    return ListElement(dt: dt, main: main, weather: weatherDetails, wind: wind, clouds: clouds, visibility: visibility, dtTxt: dtTxt);
}

  // Map<String, dynamic> toJson() => {
  //   "dt": dt,
  //   "main": main.toJson(),
  //   "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
  //   "clouds": clouds.toJson(),
  //   "visibility": visibility,
  //   "dt_txt": dtTxt.toIso8601String(),
  // };
}

class Clouds {
  Clouds({
    required this.all,
  });

  int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all,
  };
}

class MainClass {
  MainClass({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  factory MainClass.fromJson(Map<String, dynamic> json) => MainClass(
    temp: json["temp"].toDouble(),
    feelsLike: json["feels_like"].toDouble(),
    tempMin: json["temp_min"].toDouble(),
    tempMax: json["temp_max"].toDouble(),
    pressure: json["pressure"],
    seaLevel: json["sea_level"],
    grndLevel: json["grnd_level"],
    humidity: json["humidity"],
    tempKf: json["temp_kf"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp,
    "feels_like": feelsLike,
    "temp_min": tempMin,
    "temp_max": tempMax,
    "pressure": pressure,
    "sea_level": seaLevel,
    "grnd_level": grndLevel,
    "humidity": humidity,
    "temp_kf": tempKf,
  };
}

// class Rain {
//   Rain({
//     required this.the3H,
//   });
//
//   double the3H;
//
//   factory Rain.fromJson(Map<String, dynamic> json) => Rain(
//     the3H: json["3h"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "3h": the3H,
//   };
// }

// class Sys {
//   Sys({
//     required this.pod,
//   });
//
//   Pod pod;
//
//   factory Sys.fromJson(Map<String, dynamic> json) => Sys(
//     pod: podValues.map[json["pod"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pod": podValues.reverse[pod],
//   };
// }

// enum Pod { D, N }

// final podValues = EnumValues({
//   "d": Pod.D,
//   "n": Pod.N
// });

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${icon}@2x.png';
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    final main = json["main"];
    final description = json["description"];
    final icon = json["icon"];

    return Weather(id: id, main: main, description: description, icon: icon);
  }

}
//
// enum Description { BROKEN_CLOUDS, LIGHT_RAIN, OVERCAST_CLOUDS, MODERATE_RAIN }
//
// final descriptionValues = EnumValues({
//   "broken clouds": Description.BROKEN_CLOUDS,
//   "light rain": Description.LIGHT_RAIN,
//   "moderate rain": Description.MODERATE_RAIN,
//   "overcast clouds": Description.OVERCAST_CLOUDS
// });
//
// enum Icon { THE_04_D, THE_04_N, THE_10_N, THE_10_D }
//
// final iconValues = EnumValues({
//   "04d": Icon.THE_04_D,
//   "04n": Icon.THE_04_N,
//   "10d": Icon.THE_10_D,
//   "10n": Icon.THE_10_N
// });
//
// enum MainEnum { CLOUDS, RAIN }
//
// final mainEnumValues = EnumValues({
//   "Clouds": MainEnum.CLOUDS,
//   "Rain": MainEnum.RAIN
// });

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  double speed;
  int deg;
  double gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    speed: json["speed"].toDouble(),
    deg: json["deg"],
    gust: json["gust"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "speed": speed,
    "deg": deg,
    "gust": gust,
  };
}

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
