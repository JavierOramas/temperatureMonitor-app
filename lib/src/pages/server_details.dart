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
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              dataProvider.ObteneMediciones(name);
              this.setState(() {});
            },
            backgroundColor: Colors.deepOrangeAccent,
            child: Icon(Icons.av_timer),
          ),
          SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            onPressed: () {
              dataProvider.LimpiarDatos(name);
              this.setState(() {});
            },
            child: Icon(Icons.brush),
            backgroundColor: Colors.deepOrangeAccent,
          ),
        ],
      ),
    );
  }

  Widget _lista(String name) {
    return FutureBuilder(
      future: dataProvider.cargarDetails(name),
      initialData: [],
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          widget.currentServer = Server.fromJsonMap(snapshot.data);
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    // Text("IP/Domain: "+snapshot.data[0],style: TextStyle(fontSize: 15.0),textAlign: TextAlign.left,),
                    Text(
                      "CPU Info",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 10.0),
                    LineChartTemperature(
                        data: getData(widget.currentServer.date,
                            widget.currentServer.packageId0)),
                  ] +
                  getCores(widget.currentServer) +
                  getDisks(widget.currentServer),
            ),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Map<double, double> getData(
      Map<String, String> dataX, Map<String, double> dataY) {
    Map<double, double> output = new Map<double, double>();
    // List<DateTime> dates_temp = [];
    // double initial = 1;
    // for(String i in dataX.keys){
    //   initial = DateTime.parse(dataX[i]).millisecondsSinceEpoch/1;
    //   break;
    // }
    for (String i in dataY.keys) {
      // DateTime date = DateTime.parse(dataX[i]);
      int idx = int.tryParse(i);
      output[idx / 1] = dataY[i];
      // dates_temp.add(date);
    }
    return output;
  }

  List<Widget> getCores(Server server) {
    List<Widget> output = [];
    for (int i = 0; i <= server.nCores; i++) {
      output.add(Text(
        'Core $i',
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
      output.add(LineChartTemperature(
        data: getData(server.date, Map<String, double>.from(server.cores[i])),
      ));
    }
    return output;
  }

  List<Widget> getDisks(Server currentServer) {
    List<Widget> output = [
      SizedBox(
        height: 10.0,
      ),
      Text(
        "HDD Info",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
        textAlign: TextAlign.left,
      ),
    ];
    for (String i in currentServer.disksName) {
      output.add(Text(
        i,
        style: TextStyle(fontWeight: FontWeight.bold),
      ));
      output.add(LineChartTemperature(
        data: getData(currentServer.date,
            Map<String, double>.from(currentServer.disks[i])),
      ));
    }
    return output;
  }

  Widget Menu(String name) {
    return Center(
      child: Column(
        children: <Widget>[
          FlatButton(onPressed: () {}, child: Text('Measure Temperature'))
        ],
      ),
    );
  }
}
