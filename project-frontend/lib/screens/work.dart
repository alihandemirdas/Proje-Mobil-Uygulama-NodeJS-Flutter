import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proje/controllers/addMoney.dart';
import 'package:proje/controllers/addTaskToWork.dart';
import 'package:proje/controllers/addWork.dart';
import 'package:proje/controllers/deleteMoneyByWorkId.dart';
import 'package:proje/controllers/getAllTasks.dart';
import 'package:proje/controllers/getAllTasksCount.dart';
import 'dart:async';

import 'package:proje/controllers/getAllWorks.dart';
import 'package:proje/screens/login.dart';
import 'package:proje/screens/task.dart';

class WorkPage extends StatefulWidget
{
  String id, name;
  WorkPage({required this.id, required this.name});

  @override
  State<StatefulWidget> createState() {
    return _WorkPageState();
  }
}

class _WorkPageState extends State<WorkPage>
{
  List myList = [];
  //String name = "";
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController moneyController = TextEditingController();
  DateTime? selectedDate;
  var selectedOption;
  List<bool> checkedList = [];


  @override
  void initState() {
    super.initState();
    doGetAllWorks(widget.id);
    initializeDateFormatting('tr_TR');
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
                  /*Flexible(
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
                  ),*/
                ],
              ),
              SizedBox(height: 20,),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(2),
                  shrinkWrap: true,
                  itemCount: myList.length,
                  itemBuilder: (context, index) {
                    var containers = myList.map((e) => InkWell(
                      onTap: () {
                        print("buraya");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskPage(userid: widget.id, workid: e["_id"], name: widget.name, status: e["status"],),
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

  doGetAllTasksCount(String id) async{
    var res = await getAllTasksCount(id);
    if (res['status'] == 'SUCCESS'){
      String tum = res["data"];
      return tum;
    }
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
      checkedList = List.generate(myList.length, (index) => false);
      setState(() {});
    }
    else{
      showAlertDialog(context, res['message'], "Hata");
    }
  }

  doAddMoney(String id, String title, String type, String money, String workid) async{
    var res = await addMoney(widget.id, title, type, money, workid);
    if (res['status'] == 'SUCCESS'){
      print("Money API çalıştı.");
    }
    else{
      print("Money API çalışmadı.");
    }
  }

  doDeleteMoneyByWorkId(String workid) async{
    var res = await deleteMoneyByWorkId(workid);
    if (res['status'] == 'SUCCESS'){
      print("İşe ait money silindi.");
    }
    else{
      print("İşe ait money silinmedi.");
    }

  }

  doAddWork(String title, String status, String short, String lastDate, String money) async{
    var res = await addWork(widget.id, title, status, short, lastDate, money);
    if (res['status'] == 'SUCCESS'){

      if(status == "Tamamlanmış"){
        doAddMoney(widget.id, title, "Gelir", money, res['workid']);
      }else{
        doAddMoney(widget.id, title, "Alacak", money, res['workid']);
      }

      showAlertDialog(context, "İş başarıyla eklendi", "Başarılı");
      doGetAllWorks(widget.id);
      setState(() {});
    }
    else{
      showAlertDialog(context, res['message'], "Hata");
    }
  }

  doAddTaskToWork(String title, String long) async{
    var res = await addTaskToWork(widget.id, 'abc', title, long, "false");
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

    List<String> options = [
      'Aktif',
      'Bekleyen',
      'Tamamlanmış',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                  InkWell(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDate = picked;
                          dateController.text = DateFormat.yMd('tr_TR').format(selectedDate!);
                        });
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: 'Tarih',
                          suffixIcon: Icon(Icons.calendar_month),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  DropdownButton<String>(
                    value: selectedOption,
                    hint: Text("İş Durumu"),
                    items: options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedOption = newValue;
                      });
                    },
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
                    doAddWork(titleController.text, selectedOption, shortController.text, dateController.text, moneyController.text); // seçilen tarihi ekleyeceğimiz işin bitirilmesi gereken tarihi olarak kaydediyoruz
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }



}