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
  Widget widgets;
  String name = '';
  int lastIdx = 0;
  @override
  Widget build(BuildContext context) {
    name = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.deepOrange,
      ),
      body: widgets,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepOrangeAccent,
        currentIndex: 0,
        onTap: (index) => _bottomNavBarSelect(index, widget.currentServer),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text("CPU"),
            backgroundColor: Colors.deepOrangeAccent,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.storage),
              title: Text("HDD"),
              backgroundColor: Colors.deepOrangeAccent),
          BottomNavigationBarItem(
            icon: Icon(Icons.av_timer),
            title: Text("Measure"),
            backgroundColor: Colors.deepOrangeAccent,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.brush),
              title: Text("Clear"),
              backgroundColor: Colors.deepOrangeAccent)
        ],
      ),
    );
  }

  Widget _getCores(String name) {
    return FutureBuilder(
      future: dataProvider.cargarDetails(name),
      initialData: [],
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          widget.currentServer = Server.fromJsonMap(snapshot.data);
          return ListView(
            padding: EdgeInsets.all(10.0),
            children: getCores(widget.currentServer),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }

  Widget _getDisks(String name) {
    return FutureBuilder(
      future: dataProvider.cargarDetails(name),
      initialData: [],
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          widget.currentServer = Server.fromJsonMap(snapshot.data);
          return ListView(
            padding: EdgeInsets.all(10.0),
            children: getDisks(widget.currentServer),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }

  Map<double, double> getData(
      Map<String, String> dataX, Map<String, double> dataY) {
    Map<double, double> output = new Map<double, double>();

    for (String i in dataY.keys) {
      // DateTime date = DateTime.parse(dataX[i]);
      int idx = int.tryParse(i);
      output[idx / 1] = dataY[i];
      // dates_temp.add(date);
    }
    return output;
  }

  List<Widget> getCores(Server server) {
    List<Widget> output = [
      Text(
        "CPU Info",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
        textAlign: TextAlign.left,
      ),
      SizedBox(height: 10.0),
      LineChartTemperature(
          data: getData(
              widget.currentServer.date, widget.currentServer.packageId0)),
    ];
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

  _bottomNavBarSelect(int index, Server currentServer) {
    switch (index) {
      case 0:
        widgets = _getCores(name);
        lastIdx = 0;
        this.setState(() {});
        break;
      case 1:
        widgets = _getDisks(name);
        lastIdx = 1;
        this.setState(() {});
        break;
      case 2:
        dataProvider.ObteneMediciones(name);
        lastIdx == 0 ? widgets = _getCores(name) : widgets = _getDisks(name);
        this.setState(() {});
        break;
      case 3:
        dataProvider.LimpiarDatos(name);
        lastIdx == 0 ? widgets = _getCores(name) : widgets = _getDisks(name);
        this.setState(() {});
        break;
    }
  }
}
