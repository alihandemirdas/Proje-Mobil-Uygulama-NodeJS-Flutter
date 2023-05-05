import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:proje/controllers/getAllWorks.dart';

class WorkPage extends StatefulWidget
{
  String id;
  WorkPage({required this.id});

  @override
  State<StatefulWidget> createState() {
    return _WorkPageState();
  }
}

class _WorkPageState extends State<WorkPage>
{
  List myList = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortController = TextEditingController();


  @override
  void initState() {
    super.initState();
    doGetAllWorks(widget.id);
  }


  @override
  Widget build(BuildContext context){
    return Material(
      child: ListView.builder(
          padding: EdgeInsets.all(5),
          itemCount: myList.length,
          itemBuilder: (context, index) {
            var containers = myList.map((e) => Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              color: Colors.yellowAccent,
              child: Text(e["short"]),
            )).toList();
            return containers[index];
          }
      ),
    );

  }

  doGetAllWorks(String id) async{
    var res = await getAllWorks(widget.id);
    if (res['status'] == 'SUCCESS'){
      myList = res['data'];
      print("Buraya geliyor.");
      setState(() {});
    }
    else{
      showAlertDialog(context, res['message'], "Hata");
    }
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