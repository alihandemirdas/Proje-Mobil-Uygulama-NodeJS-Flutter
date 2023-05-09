import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proje/controllers/addTaskToWork.dart';
import 'package:proje/controllers/addWork.dart';
import 'package:proje/controllers/getAllTasks.dart';
import 'dart:async';

import 'package:proje/controllers/getAllWorks.dart';
import 'package:proje/screens/login.dart';
import 'package:proje/screens/task.dart';

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
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 90, 20, 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xffF1E5FB),
          ),
          child: Column(
            children: [
              Row(
                children: [
                Text("MEVCUT İŞLER",
                  style: TextStyle(
                      color: Color(0xffEE6352),
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ],),
              SizedBox(height: 20,),
              Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                        onPressed: (){
                          addWorkDialog();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff08B2E3),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                            padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                            minimumSize: Size.fromHeight(0)
                        ),
                        child: const Text("İŞ EKLE", style: TextStyle(color: Color(0xff484D6D), fontSize: 15, fontWeight: FontWeight.w900),)
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff08B2E3),
                            shape: RoundedRectangleBorder( //to set border radius to button
                                borderRadius: BorderRadius.circular(30)
                            ),
                            padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                            minimumSize: Size.fromHeight(0)
                        ),
                        child: const Text("İŞ SİL", style: TextStyle(color: Color(0xff484D6D), fontSize: 15, fontWeight: FontWeight.w900),)
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
                      var containers = myList.map((e) => InkWell(
                        onTap: () {
                          print("buraya");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskPage(userid: widget.id, workid: e["_id"]),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(7),
                          padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffD9D9D9),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(e["title"],style: TextStyle(color: Color(0xff000000),fontFamily: 'Montserrat', fontSize: 20, fontWeight: FontWeight.w600),),)
                                ],
                              ),
                              SizedBox(height: 10,),
                              Divider(color: Color(0xffEE6352), thickness: 1),
                              Row(
                                children: [
                                  Expanded(child: Text(e["short"],),)
                                ],
                              ),
                            ],
                          ),
                        ),
                      )).toList();
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

  doGetAllTasks(String id) async{
    var res = await getAllTasks(id);
    if (res['status'] == 'SUCCESS'){
      return res['data'];
    }
    else{
      showAlertDialog(context, res['message'], "Hata");
    }
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

  doAddWork(String title, String short ) async{
    var res = await addWork(widget.id, title, "Active", short);
    if (res['status'] == 'SUCCESS'){
      showAlertDialog(context, "İş başarıyla eklendi", "Başarılı");
      doGetAllWorks(widget.id);
      print("Buraya geliyor.");
      setState(() {});
    }
    else{
      showAlertDialog(context, res['message'], "Hata");
    }
  }

  doAddTaskToWork(String title, String long) async{
    var res = await addTaskToWork(widget.id, 'abc', title, long);
    if (res['status'] == 'SUCCESS'){
      showAlertDialog(context, "Görev başarıyla eklendi", "Başarılı");
      doGetAllWorks(widget.id);
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

  void addWorkDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('İş Ekle'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Başlık'),
                ),
                TextField(
                  controller: shortController,
                  decoration: InputDecoration(labelText: 'Kısa Açıklama'),
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
                  doAddWork(titleController.text, shortController.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

}