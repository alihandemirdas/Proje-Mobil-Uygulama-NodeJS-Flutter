import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proje/screens/login.dart';
import 'package:proje/screens/register.dart';
import 'package:proje/screens/work.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Donem Projesi',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(fontFamily: 'Montserrat'),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    goLoginPage();
    //goRegisterPage();
  }

  void goRegisterPage() {
    Timer(Duration(seconds: 5), () {
      Route route = MaterialPageRoute(builder: (_) => RegisterPage());
      Navigator.pushReplacement(context, route);
    });
  }

  void goLoginPage() {
    Timer(Duration(seconds: 1), () {
      Route route = MaterialPageRoute(builder: (_) => LoginPage());
      Navigator.pushReplacement(context, route);
    });
  }

  /*void goWorkPage() {
    Timer(Duration(seconds: 5), () {
      Route route = MaterialPageRoute(builder: (_) => WorkPage());
      Navigator.pushReplacement(context, route);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: Color(0xffefe9f4),
        child: Center(
            child: Text("ANA SAYFA")
        ),
      ),
    );
  }
}
