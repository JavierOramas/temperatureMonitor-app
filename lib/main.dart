import  'package:flutter/material.dart';
import 'package:temp_monitor_app/src/routes/routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Monitor',
      debugShowCheckedModeBanner: false,
      
      initialRoute: '/',
      routes: getApplicationRoutes(),

    );
  }
}