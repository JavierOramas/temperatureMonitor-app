import 'package:flutter/material.dart';

class ServerDetailsPage extends StatefulWidget {
  ServerDetailsPage({Key key}) : super(key: key);

  @override
  _ServerDetailsPageState createState() => _ServerDetailsPageState();
}

class _ServerDetailsPageState extends State<ServerDetailsPage> {

  @override
  Widget build(BuildContext context) {
    
    final String name = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.deepOrange,
      )
    );
  }
}