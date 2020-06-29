import 'package:flutter/material.dart';
import 'package:temp_monitor_app/src/providers/data_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Temperature Monitor"),
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
      builder: (context, AsyncSnapshot<dynamic> snapshot){
        
        List<dynamic> names = [];
        for (String i in snapshot.data){
          names.add(i);
        }


        return Column(
          children:_createList(names, context)
          );
      },
    );

  }

  _createList(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach( (opt) {

    final card = Container(
      // clipBehavior: Clip.antiAlias,
      // elevation: 10.0,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(opt)
            )
          
        ]
      ),
    );

    final widgetTemp = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset:Offset(2.0, 10),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            color: Colors.black26 
          )
        ],
        borderRadius: BorderRadius.circular(20.0),
        ),
      child: ClipRRect(
        child: card,
        borderRadius: BorderRadius.circular(20.0),
        )
      );

      opciones..add(widgetTemp)
              ..add(Divider());
      }
    );
    return opciones;
  }

}