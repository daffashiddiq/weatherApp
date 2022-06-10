import 'dart:convert';
import 'dart:ffi';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather.dart';

import 'province.dart';
import 'city.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController();
  String name = '';
  String? idProvince;
  String namaKota = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama Anda',
                  ),
                  onChanged: (text) {
                    setState(() {
                      name = controller.text;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: DropdownSearch<Province>(
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    itemBuilder: (context, item, isSelected) => ListTile(
                      title: Text(item.nama),
                    ),
                  ),
                  onChanged: (value) => idProvince = value?.id.toString(),
                  dropdownBuilder: (context, item) =>
                      Text(item?.nama ?? "Belum memilih provinsi"),
                  asyncItems: (text) async {
                    var response = await http.get(Uri.parse(
                        "http://dev.farizdotid.com/api/daerahindonesia/provinsi"));
                    if (response.statusCode != 200) {
                      return [];
                    }
                    List allProvince = (jsonDecode(response.body)
                        as Map<String, dynamic>)["provinsi"];
                    List<Province> allModelProvince = [];

                    allProvince.forEach((element) {
                      allModelProvince.add(
                          Province(id: element["id"], nama: element["nama"]));
                    });
                    return allModelProvince;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: DropdownSearch<City>(
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    itemBuilder: (context,item,isSelected) => ListTile(
                      title: Text(item.nama),
                    ),
                  ),
                  onChanged: (value) => namaKota = value!.nama,
                  dropdownBuilder: (context,item) => Text(item?.nama ?? "Belum memilih kota"),
                  asyncItems: (text) async {
                    var response = await http.get(Uri.parse(
                        "http://dev.farizdotid.com/api/daerahindonesia/kota?id_provinsi=$idProvince"));
                    if (response.statusCode != 200) {
                      return [];
                    }
                    List allCity = (jsonDecode(response.body)
                        as Map<String, dynamic>)["kota_kabupaten"];
                    List<City> allNameCity = [];

                    allCity.forEach((element) {
                      allNameCity.add(City(id: element["id"], idProvinsi: element["id_provinsi"], nama: element["nama"]));
                    });
                    return allNameCity;
                  },
                ),
              ),
              Builder(
                builder: (context) {
                  return TextButton(
                    child: Text('Lanjut'),
                    onPressed: () {
                      pindahPage(context);
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
  void pindahPage(BuildContext context) {
    String nameToSend = this.name;
    String cityToSend = this.namaKota;
    Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherApp(nama: nameToSend, kota: cityToSend,)));
  }
}
