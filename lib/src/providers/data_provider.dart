
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';


class _DataProvider{

  List<dynamic> opciones = [];

  _DataProvider(){
    cargarData();
  }

  Future<List<dynamic>> cargarData() async{
    
    // final resp = await rootBundle.loadString('data/menu_opts.json');
    // Map mapJson = json.decode(resp);
    // opciones = mapJson['rutas'];
    // return opciones;
    return [];
    }
  } 

var dataProvider = _DataProvider();