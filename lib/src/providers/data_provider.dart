import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

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
}

var dataProvider = _DataProvider();
