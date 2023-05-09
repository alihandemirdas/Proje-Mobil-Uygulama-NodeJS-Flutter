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
    //goLoginPage();
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

  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Özet',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Takip',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Muhasebe',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
    Text(
      'Market',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Özet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Takip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Muhasebe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Market',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffEE6352),
        fixedColor: Color(0xff000000),
        //selectedItemColor: Color(0xff000000),
        onTap: _onItemTapped,
      ),
    );
  }
}
