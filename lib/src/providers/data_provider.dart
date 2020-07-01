import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;


class _DataProvider {
  List<dynamic> opciones = [];

  _DataProvider() {
    cargarData();
  }

  Future<dynamic> cargarData() async {
    final resp = await rootBundle.loadString('data/serverslist.json');
    Map mapJson = json.decode(resp);
    return mapJson.keys;
    // return [];
  }

    Future<dynamic> cargarDetails(String name) async {
    final resp = await rootBundle.loadString('data/serverslist.json');
    Map mapJson = json.decode(resp);
    String ip = mapJson[name][0];
    String port = mapJson[name][1];
    String url = 'http://$ip:$port/temps';
    List<dynamic> response = [];

    final jsonFile = await http.get( url );
    // print(jsonFile.body);
    // Uri uri = new Uri(host: ip, port: int_port);
    final decodedData = Map<String, dynamic>.from(json.decode(jsonFile.body));
    // response.add(decodedData);
    return decodedData;
  }
}

var dataProvider = _DataProvider();
