import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'weatherModel.dart';

class WeatherApp extends StatefulWidget {
  final String nama;
  final String kota;
  final WeatherModel weatherData;

  const WeatherApp(
      {Key? key,
      required this.nama,
      required this.kota,
      required this.weatherData})
      : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late var groupByDay =
      groupBy(widget.weatherData.list, (obj) => obj.dtTxt.day);

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
          top: 20,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    _greetingName(),
                    _temprature(),
                  ],
                ),
                Spacer(
                  flex: 10,
                ),
                Column(
                  children: [
                    _condition(),
                    _cloudIcon(),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      _humidity(),
                      Text(
                        '${widget.weatherData.list[0].main.humidity} % Humidity',
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      _humidity(),
                      Text(
                        '${widget.weatherData.list[0].main.pressure} hpa Pressure',
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      _cloudinessIcon(),
                      Text(
                        '${widget.weatherData.list[0].clouds.all} % Cloudiness',
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      _windIcon(),
                      Text(
                        '${widget.weatherData.list[0].wind.speed} m/s Wind',
                        maxLines: 2,
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            getAllWeatherData(),
          ],
        ),
      ),
    );
  }

  Widget getAllWeatherData() {
    List<Widget> listWeather = [];
    groupByDay.forEach((date, list) {
      List<Widget> listWeatherByDay =[];

      list.forEach((element) {
        Widget columnByHour = Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${element.dtTxt.hour}:00'),
                Image.network(element.weather.iconUrl, width: 50, height: 50, fit: BoxFit.contain),
                Text('${element.main.temp} \u2103')
              ],
            ),
        );
        listWeatherByDay.add(columnByHour);
      });

      Widget listPerDayWeather =
      Container(
        height: 150,
        child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 1,
              itemBuilder: (content, index) {
                return Row(
                  children: listWeatherByDay,
                );
              }),
      );
      listWeather.add(listPerDayWeather);
    });
    return Expanded(child: ListView(children: listWeather));
  }

  _windIcon() {
    return Container(
      child: Icon(Icons.speed),
    );
  }

  _cloudinessIcon() {
    return Container(
      child: Icon(Icons.cloud),
    );
  }

  _humidity() {
    return Container(
      child: Icon(Icons.water_drop),
    );
  }

  _condition() {
    return Text(widget.weatherData.list[0].weather.main);
  }

  _cloudIcon() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network(widget.weatherData.list[0].weather.iconUrl),
    );
  }

  _temprature() {
    return Text(
      '${widget.weatherData.list[0].main.temp}',
      style: TextStyle(
        fontSize: 80,
        fontWeight: FontWeight.w100,
      ),
    );
  }

  _greetingName() {
    return Text('Selamat Pagi ${widget.nama}');
  }
}
