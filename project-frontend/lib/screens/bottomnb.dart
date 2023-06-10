import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proje/controllers/addTaskToWork.dart';
import 'package:proje/controllers/addWork.dart';
import 'dart:async';


import 'package:proje/screens/accounting.dart';
import 'package:proje/screens/home.dart';
import 'package:proje/screens/login.dart';
import 'package:proje/screens/market.dart';
import 'package:proje/screens/register.dart';
import 'package:proje/screens/work.dart';

class BnbPage extends StatefulWidget
{
  String userid, name;
  int selectedIndex;
  BnbPage({required this.userid, required this.name, required this.selectedIndex});

  @override
  State<StatefulWidget> createState() {
    return _BnbPageState();
  }
}

class _BnbPageState extends State<BnbPage>
{
  List sc = [];
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    final screens = [
      HomePage(userid: widget.userid, name: widget.name),
      WorkPage(id: widget.userid, name: widget.name),
      AccountingPage(id: widget.userid,),
      MarketPage()
    ];
    sc = screens;
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: sc.elementAt(_selectedIndex),
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
            icon: Icon(Icons.logout),
            label: 'Çıkış',
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

  showAlertDialog(BuildContext context, String data, String title) {

    Widget okButton = TextButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true)
            .pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xffF1E5FB),
      title: Text('${title}'),
      content: Text('${data}'),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}