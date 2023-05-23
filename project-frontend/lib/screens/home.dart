import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:proje/controllers/addTaskToWork.dart';
import 'package:proje/controllers/addWork.dart';
import 'package:proje/controllers/getAllMoney.dart';
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
  double toplam = 0;
  List myList = [];
  List money = [];
  var kontrol = 0;


  @override
  void initState() {
    super.initState();
    doGetAllWorks(widget.userid);
    doGetAllMoney();
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
                  Text(" (Son Tarihe Göre)",
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
              SingleChildScrollView(
                child: ListView.builder(
                    padding: EdgeInsets.all(2),
                    itemCount: myList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
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
                                      myList[i]["title"],
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
                                children: [
                                  Expanded(
                                      child: Text(myList[i]["short"])
                                  ),
                                  SizedBox(width: 10,),
                                  Text("Son: ${myList[i]["lastDate"]}", )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
              SizedBox(height: 10,),
              Divider(color: Color(0xff484D6D), thickness: 1, indent: 30, endIndent: 30,),
              SizedBox(height: 10,),
              Card(
                elevation: 8.0,
                color: Color(0xffC5C5C5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
                child: Container(
                  height: 100,
                  padding: EdgeInsets.only(left:5,right:5,bottom:5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text("Kesinleşen Kazancın: ",textAlign: TextAlign.center, style: TextStyle(
                            color: Color(0xff484D6D),
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                        ),),
                      ),
                      SizedBox(height: 5,),
                      Text("${toplam}₺", textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xff00AA1B),
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  doGetAllMoney() async{
    var res = await getAllMoney(widget.userid);
    if (res['status'] == 'SUCCESS'){
      money = res['data'];
      double gider = 0;
      double gelir = 0;
      for(int i=0; i<money.length; i++){
        if(money[i]["type"] == "Gelir"){
          gelir += money[i]["money"];
        }
        if(money[i]["type"] == "Gider"){
          gider += money[i]["money"];
        }
      }

      toplam = gelir-gider;
      setState(() {});
    }
  }

  doGetAllWorks(String id) async{
    var res = await getAllWorks(widget.userid);
    if (res['status'] == 'SUCCESS'){
      myList = res['data'];

      myList.removeWhere((item) => item["status"] == "Tamamlanmış");

      myList.sort((a, b) {
        DateTime dateA = DateFormat('dd.MM.yyyy').parse(a['lastDate']);
        DateTime dateB = DateFormat('dd.MM.yyyy').parse(b['lastDate']);
        return dateA.compareTo(dateB);
      });

      myList = myList.sublist(0, 3);
      print(myList);

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