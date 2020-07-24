import 'package:flutter/material.dart';
import 'package:temp_monitor_app/src/providers/data_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature Monitor"),
        backgroundColor: Colors.deepOrange,
      ),
      body: _lista(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'addServer')
            .then((value) => {this.setState(() {})}),
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  Widget _lista(BuildContext context) {
    return ListView(children: _createList(dataProvider.cargarData(), context));
  }

  _createList(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final ListTile widgetTemp = ListTile(
          title: Text(opt),
          leading: Icon(
            Icons.storage,
            color: Colors.orangeAccent,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.orangeAccent,
          ),
          onTap: () {
            Navigator.pushNamed(context, 'serverDetails', arguments: opt);
          },
          onLongPress: () => {
                dataProvider.deleteEntry(opt),
                this.setState(() {}),
              });

      opciones..add(widgetTemp)..add(Divider());
    });
    return opciones;
  }
}
