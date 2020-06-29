import 'package:flutter/material.dart';
import 'package:temp_monitor_app/src/pages/add_server_page.dart';
import 'package:temp_monitor_app/src/pages/home_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'addServer': (BuildContext context) => AddServerPage(),
  };
}
