import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proje/screens/login.dart';
import 'package:proje/screens/resetPassword.dart';
import 'package:proje/controllers/userRegister.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  void initState() {
    super.initState();
    //goResetPasswordPage();
  }

  void goResetPasswordPage() {
    Timer(Duration(seconds: 10), () {
      Route route = MaterialPageRoute(builder: (_) => ResetPasswordPage());
      Navigator.pushReplacement(context, route);
    });
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 125),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xffF1E5FB),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const Text("KAYIT OL",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 35,
                    fontWeight: FontWeight.w700
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(color: Color(0xff484D6D), thickness: 1),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      //width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        controller: nameController,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "Ad:",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      //width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5),
                      child: TextFormField(
                        controller: surnameController,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: "Soyad:",
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "E-posta:",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: usernameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: "Kullanıcı Adı:",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffD9D9D9),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Şifre:",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 25,),
              ElevatedButton(
                  onPressed: (){
                    if(nameController.text.isNotEmpty && surnameController.text.isNotEmpty && emailController.text.isNotEmpty && usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
                      doRegister(nameController.text, surnameController.text, emailController.text, usernameController.text,passwordController.text);
                    }
                    else{
                      showAlertDialog(context, "Boş bırakılan alanları doldurunuz.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffEE6352),
                      shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(40)
                      ),
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                      minimumSize: Size.fromHeight(0)
                  ),
                  child: const Text("KAYIT OL", style: TextStyle(color: Color(0xff484D6D), fontSize: 15, fontWeight: FontWeight.w900),)
              ),
            ],
          ),
        ),
      ),
    );
  }

  doRegister(String name, String surname, String email, String username, String password) async{
    var res = await userRegister(name.trim(), surname.trim(), email.trim(), username.trim(), password.trim());
    if (res['status'] == 'SUCCESS'){
      print(res['message']);
      showAlertDialog(context, res['message']);
      Timer(Duration(seconds: 3), () {
        Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
    else{
      print(res['message']);
      showAlertDialog(context, res['message']);
    }
  }

  showAlertDialog(BuildContext context, String data) {

    Widget okButton = TextButton(
      child: Text("Tamam"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true)
            .pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xffF1E5FB),
      title: Text("Hata"),
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
