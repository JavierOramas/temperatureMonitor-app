import 'package:flutter/material.dart';
import 'package:temp_monitor_app/src/models/server_model.dart';
import 'package:temp_monitor_app/src/providers/data_provider.dart';
import 'package:temp_monitor_app/src/widgets/line_chart.dart';


class ServerDetailsPage extends StatefulWidget {
  ServerDetailsPage({Key key}) : super(key: key);
  Server currentServer;

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
        else 
          widget.currentServer = Server.fromJsonMap(snapshot.data);
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                // Text("IP/Domain: "+snapshot.data[0],style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                Text("CPU Info", 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                    textAlign: TextAlign.left,
                ),
                SizedBox(height:10.0),
                LineChartTemperature(data: widget.currentServer,), 
              ],
            ),
          );
      },
    );
  }

}