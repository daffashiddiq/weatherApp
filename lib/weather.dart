import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'modelWeather.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  final String nama;
  final String kota;

  const WeatherApp({Key? key, required this.nama, required this.kota})
      : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.kota}'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _cloudIcon(),
            _temprature(),
            _greetingName(),
            _location(),
            _date(),
            _hourlyPrediction(),
            _weeklyPrediction(),
          ],
        ),
      ),
    );
  }

  _cloudIcon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        Icons.cloud,
        size: 80,
      ),
    );
  }

  _temprature() {
    return Text(
      '25',
      style: TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.w100,
      ),
    );
  }

  _greetingName() {
    return Text('Selamat Pagi ${widget.nama}');
  }

  _location() {
    return Row(
      children: [
        Icon(Icons.place),
        SizedBox(
          width: 10,
        ),
        Text('Indonesia'),
      ],
    );
  }

  _date() {
    return Row(
      children: [
        Text('Today: '),
        SizedBox(
          width: 10,
        ),
        Text('10.06.2022'),
      ],
    );
  }

  final times = ['1','2','3','4','5','2','3','4'];
  _hourlyPrediction() {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      ),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: times.length,
          itemBuilder: (context, index) {
        return Container(
          width: 50,
          child: Card(
            color: Colors.black12,
            child: Center(
              child: Text('${times[index]}'),
            ),
          ),
        );
      }),
    );
  }

  final days = ['1','2','3','4','5'];
  _weeklyPrediction() {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.black),
            bottom: BorderSide(color: Colors.black),
          ),
        ),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: times.length,
            itemBuilder: (context, index) {
              return Container(
                height: 50,
                child: Card(
                  color: Colors.black12,
                  child: Center(
                    child: Text('${days[index]}'),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
