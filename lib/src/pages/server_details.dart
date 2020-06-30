import 'package:flutter/material.dart';
import 'package:temp_monitor_app/src/providers/data_provider.dart';


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
      ),
      body: _lista(name),
    );

  }

  Widget _lista(String name) {
    
    return FutureBuilder(
      future: dataProvider.cargarDetails(name),
      initialData: [],
      builder: (context, AsyncSnapshot<dynamic> snapshot){
        if (! snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        else return Center(child: Text(snapshot.data[0]));
      },
    );
  }

}