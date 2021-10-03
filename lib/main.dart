import 'package:flutter/material.dart';
import 'package:pico_de_oro/src/pages/client/products/list/client_products_list_pages.dart';
import 'package:pico_de_oro/src/pages/login/login_page.dart';
import 'package:pico_de_oro/src/pages/register/register_page.dart';
import 'src/pages/register/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pico de oro app',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
        'client/products/list': (BuildContext context) =>
            ClientProductListPage(),
      },
    );
  }
}
