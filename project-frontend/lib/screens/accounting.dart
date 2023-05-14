import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proje/controllers/addMoney.dart';
import 'package:proje/controllers/addTaskToWork.dart';
import 'package:proje/controllers/addWork.dart';
import 'package:proje/controllers/getAllMoney.dart';
import 'package:proje/controllers/getAllTasks.dart';
import 'dart:async';

import 'package:proje/controllers/getAllWorks.dart';
import 'package:proje/screens/login.dart';

class AccountingPage extends StatefulWidget
{
  String id;
  AccountingPage({required this.id});
  @override
  State<StatefulWidget> createState() {
    return _AccountingPageState();
  }
}

class _AccountingPageState extends State<AccountingPage>
{
  List myList = [];
  double toplam = 0;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController moneyController = TextEditingController();


  @override
  void initState() {
    super.initState();
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
              Card(
                elevation: 4.0,
                color: Color(0xffC5C5C5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
                child: Container(
                  height: 200,
                  padding: EdgeInsets.only(left:16,right:16,bottom:20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: Text("Kesinleşen Kazanç:", style: TextStyle(
                          color: Color(0xff484D6D),
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                      SizedBox(height: 40,),
                      Text("${toplam}₺", textAlign: TextAlign.center,style: TextStyle(fontSize: 30, color: Color(0xff00AA1B), fontWeight: FontWeight.w700),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                        onPressed: (){
                          String type = "Gelir";
                          addMoneyDialog(type);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff08B2E3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                            minimumSize: Size.fromHeight(0)
                        ),
                        child: const Text("GELİR EKLE", style: TextStyle(color: Color(0xff484D6D), fontSize: 13, fontWeight: FontWeight.w900),)
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: ElevatedButton(
                        onPressed: (){
                          String type = "Gider";
                          addMoneyDialog(type);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff08B2E3),
                            shape: RoundedRectangleBorder( //to set border radius to button
                                borderRadius: BorderRadius.circular(15)
                            ),
                            padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                            minimumSize: Size.fromHeight(0)
                        ),
                        child: const Text("GİDER EKLE", style: TextStyle(color: Color(0xff484D6D), fontSize: 13, fontWeight: FontWeight.w900),)
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: ElevatedButton(
                        onPressed: (){
                          String type = "Alacak";
                          addMoneyDialog(type);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff08B2E3),
                            shape: RoundedRectangleBorder( //to set border radius to button
                                borderRadius: BorderRadius.circular(15)
                            ),
                            padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                            minimumSize: Size.fromHeight(0)
                        ),
                        child: const Text("ALACAK EKLE", style: TextStyle(color: Color(0xff484D6D), fontSize: 13, fontWeight: FontWeight.w900),)
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Divider(color: Color(0xff484D6D), thickness: 1, indent: 20, endIndent: 20,),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(2),
                    itemCount: myList.length,
                    itemBuilder: (context, index) {
                      var containers = myList.map((e) => Container(
                        margin: EdgeInsets.all(7),
                        padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                         // color: Color(0xffD9D9D9),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("●"),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(e["title"],style: TextStyle(color: Color(0xff000000),fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w600),),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text("${e["money"].toString()}₺",textAlign: TextAlign.end,style: TextStyle(
                                      color: getColorMoney(e["type"]),
                                      fontFamily: 'Montserrat',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600
                                  ),),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),).toList();
                      return containers[index];
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  Color getColorMoney(String type){
    if(type == "Gelir"){
      return Colors.green;
    }
    else if(type == "Gider"){
      return Colors.red;
    }
    else if(type == "Alacak"){
      return Colors.amber;
    }
    else{
      return Colors.black;
    }
  }

  doAddMoney(String id, String title, String type, String money) async{
    var res = await addMoney(widget.id, title, type, money);
    if (res['status'] == 'SUCCESS'){
      showAlertDialog(context, "${type} başarıyla eklendi", "Başarılı");
      doGetAllMoney();
      print("Buraya geliyor.");
      setState(() {});
    }
    else{
      showAlertDialog(context, res['message'], "Hata");
    }
  }

  doGetAllMoney() async{
    var res = await getAllMoney(widget.id);
    if (res['status'] == 'SUCCESS'){
      print("a");
      myList = res['data'];
      double gider = 0;
      double gelir = 0;
      for(int i=0; i<myList.length; i++){
        if(myList[i]["type"] == "Gelir"){
          gelir += myList[i]["money"];
        }
        if(myList[i]["type"] == "Gider"){
          gider += myList[i]["money"];
        }
      }

      toplam = gelir-gider;

      myList = myList.reversed.toList();
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

  void addMoneyDialog(String type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${type} Ekle'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Başlık'),
                ),
                TextField(
                  controller: moneyController,
                  decoration: InputDecoration(labelText: 'Ücret'),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Vazgeç'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Ekle'),
                onPressed: () {
                  doAddMoney(widget.id, titleController.text, type, moneyController.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

}