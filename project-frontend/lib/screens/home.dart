import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proje/controllers/addTaskToWork.dart';
import 'package:proje/controllers/addWork.dart';
import 'package:proje/controllers/getAllTasks.dart';
import 'dart:async';

import 'package:proje/controllers/getAllWorks.dart';
import 'package:proje/screens/login.dart';

class HomePage extends StatefulWidget
{
  String userid, name;
  HomePage({required this.userid, required this.name});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
{
  List myList = [];
  var kontrol = 0;


  @override
  void initState() {
    super.initState();
    doGetAllWorks(widget.userid);
  }


  @override
  Widget build(BuildContext context){
    return Material(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xffF1E5FB),
          ),
          child: Column(
            children: [
              SizedBox(height: 25,),
              Row(
                children: [
                  Text("Hoşgeldin, ${widget.name} !",
                    style: TextStyle(
                        color: Color(0xffEE6352),
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35,),
              Row(
                children: [
                  Text("ÖZET",
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontFamily: 'Montserrat',
                        fontSize: 17,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(" (Son tarihe göre sıralanacak)",
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(2),
                    itemCount: myList.length,
                    itemBuilder: (context, index) {
                      if (index < 3) {
                        var e = myList[index];
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffD9D9D9)
                          ),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffffffff),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        e["title"],
                                        style: TextStyle(
                                            color: Color(0xff000000),
                                            fontFamily: 'Montserrat',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(color: Color(0xffEE6352), thickness: 1),
                                Row(
                                  children: [Expanded(child: Text(e["short"]))],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox.shrink(); // Görünmez widget
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  doGetAllWorks(String id) async{
    var res = await getAllWorks(widget.userid);
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