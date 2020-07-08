import 'package:flutter/material.dart';
import 'package:temp_monitor_app/src/providers/data_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature Monitor"),
        backgroundColor: Colors.deepOrange,
      ),
      body: _lista(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'addServer'),
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  Widget _lista() {
    return FutureBuilder(
      future: dataProvider.cargarData(),
      initialData: [],
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        List<dynamic> names = [];
        for (String i in snapshot.data) {
          names.add(i);
        }

        return ListView(children: _createList(names, context));
      },
    );
  }

  _createList(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((opt) {
      final ListTile widgetTemp = ListTile(
        title: Text(opt),
        // leading: getIcon(opt['icon']),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.blueAccent,
        ),
        onTap: () {
          Navigator.pushNamed(context, 'serverDetails', arguments: opt);
        },
      );

      opciones..add(widgetTemp)..add(Divider());
    });
    return opciones;
  }
}
