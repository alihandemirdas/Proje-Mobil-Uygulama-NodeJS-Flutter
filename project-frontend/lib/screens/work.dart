import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class WorkPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _WorkPageState();
  }
}

class _WorkPageState extends State<WorkPage>
{
  @override
  void initState() {
    super.initState();
  }

  /*void goRegisterPage() {
    Timer(Duration(seconds: 10), () {
      Route route = MaterialPageRoute(builder: (_) => RegisterPage());
      Navigator.pushReplacement(context, route);
    });
  }*/
  List<String> myList = ['Öğe 1', 'Öğe 2', 'Öğe 3'];

  @override
  Widget build(BuildContext context){
    return Material(
      child: SingleChildScrollView(
        child: ListView(
          children: myList.map((item) {
            return ListTile(
              title: Text(item),
            );
          }).toList(),
        ),
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