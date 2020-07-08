import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:temp_monitor_app/src/providers/data_provider.dart';

class AddServerPage extends StatefulWidget {
  AddServerPage({Key key}) : super(key: key);

  @override
  _AddServerPageState createState() => _AddServerPageState();
}

class _AddServerPageState extends State<AddServerPage> {
  String _ip = '';
  String _name = '';
  String _port = '';

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add the address of your Server"),
          backgroundColor: Colors.deepOrange,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: <Widget>[
            _getName(),
            Divider(),
            _getIP(),
            Divider(),
            _getPort(),
            Divider(),
            _confirmAdd()
          ],
        ));
  }

  Widget _getName() {
    return TextField(
      //  autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: 'Server 1',
          helperText: "Machine's Name",
          icon: Icon(Icons.computer)),
      onChanged: (valor) {
        setState(() {
          _name = valor;
        });
      },
    );
  }

  Widget _getIP() {
    return TextField(
      //  autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: '0.0.0.0 or domain.something',
          helperText: 'IP/Domain',
          icon: Icon(Icons.blur_circular)),
      onChanged: (valor) {
        setState(() {
          _ip = valor;
        });
      },
    );
  }

  Widget _getPort() {
    return TextField(
      //  autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: '8080',
          helperText: 'Port',
          icon: Icon(Icons.wb_iridescent)),
      onChanged: (valor) {
        setState(() {
          _port = valor;
        });
      },
    );
  }

  _confirmAdd() {
    return FlatButton(
      child: Text("Add"),
      color: Colors.deepOrange,
      onPressed: () async {
        final resp = await rootBundle.loadString('data/serverslist.json');
        Map mapJson = json.decode(resp);
        if (!mapJson.containsKey(_name)) {
          mapJson[_name] = [_ip, _port];
        }
        //Add error message
      },
    );
  }
}
