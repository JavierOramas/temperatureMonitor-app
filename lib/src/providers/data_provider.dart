import 'dart:convert';
// import 'dart:html';
import 'package:http/http.dart' as http;
import 'dart:io';
import "package:path_provider/path_provider.dart";
import 'package:permission_handler/permission_handler.dart';

class _DataProvider {
  List<dynamic> opciones = [];
  File jsonFile;
  Directory dir =
      Directory("/data/user/0/com.example.temp_monitor_app/app_flutter");
  String fileName = 'serverslist.json';
  bool fileExists = false;
  Map<String, List<dynamic>> fileContent;

  _DataProvider() {
    initState();
  }

  void initState() async {
    // getApplicationDocumentsDirectory().then((path) => {print(path)});
    dir = await getApplicationDocumentsDirectory();
    print(dir);
  }

  File createFile(Map content) {
    File file = new File(dir.path + '/' + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
    return file;
  }

  void writeContent(Map content) {
    if (fileExists) {
      Map jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else
      createFile(content);
  }

  cargarData() {
    jsonFile = new File(dir.path + '/' + fileName);
    fileExists = jsonFile.existsSync();
    if (fileExists) {
      // fileContent = json.decode(jsonFile.readAsStringSync());
      // fileContent = Map<String, List<String>>.from(fileContent);
      fileContent = Map<String, List<dynamic>>.from(
          json.decode(jsonFile.readAsStringSync()));
    }

    return fileContent != null && fileContent.length > 0
        ? fileContent.keys.toList()
        : [];
  }

  Future<Map<String, dynamic>> cargarDetails(String name) async {
    Map mapJson = fileContent;
    String ip = mapJson[name][0];
    String port = mapJson[name][1];
    String url = 'http://$ip:$port/temps';

    final jsonFile = await http.get(url);
    // print(jsonFile.body);
    // Uri uri = new Uri(host: ip, port: int_port);
    final decodedData = Map<String, dynamic>.from(json.decode(jsonFile.body));
    // response.add(decodedData);
    return decodedData;
  }

  Future<Map<String, dynamic>> ObteneMediciones(String name) async {
    Map mapJson = fileContent;
    String ip = mapJson[name][0];
    String port = mapJson[name][1];
    String url = 'http://$ip:$port/measure';

    final jsonFile = await http.get(url);
    return cargarDetails(name);
  }

  Future<Map<String, dynamic>> LimpiarDatos(String name) async {
    Map mapJson = fileContent;
    String ip = mapJson[name][0];
    String port = mapJson[name][1];
    String url = 'http://$ip:$port/clean';

    final jsonFile = await http.get(url);
    return cargarDetails(name);
  }
}

var dataProvider = _DataProvider();
