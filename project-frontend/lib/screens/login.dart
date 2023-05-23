import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:proje/controllers/userLogin.dart';
import 'package:proje/main.dart';
import 'package:proje/screens/bottomnb.dart';
import 'package:proje/screens/home.dart';
import 'dart:async';

import 'package:proje/screens/register.dart';
import 'package:proje/screens/resetPassword.dart';
import 'package:proje/screens/work.dart';

class LoginPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>
{
  @override
  void initState() {
    super.initState();
    //goRegisterPage();
  }

  void goRegisterPage() {
    Timer(Duration(seconds: 10), () {
      Route route = MaterialPageRoute(builder: (_) => RegisterPage());
      Navigator.pushReplacement(context, route);
    });
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Material(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 50),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xffF1E5FB),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.asset("assets/images/logo.png", fit: BoxFit.cover, width: 150, height: 150,),
              ),
              SizedBox(height: 5,),
              Form(
                key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: TextFormField(
                          controller: usernameController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: "Kullanıcı Adı:",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffD9D9D9),
                            borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Şifre:",
                              border: InputBorder.none
                          ),

                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: "Şifreni mi unuttun?",
                                style: TextStyle(color: Color(0xff000000),fontSize: 11),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                                  }
                            ),
                          )
                        ],
                      ),
                    ],
                  )
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: (){
                    if(usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
                      doLogin(usernameController.text,passwordController.text);
                    }
                    else{
                      showAlertDialog(context, "Boş bırakılan alanları doldurunuz.", "Hata");
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
                  child: const Text("GİRİŞ YAP", style: TextStyle(color: Color(0xff484D6D), fontSize: 15, fontWeight: FontWeight.w900),)
              ),
              SizedBox(height: 10,),
              Divider(
                  color: Color(0xff484D6D),
                  thickness: 1
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Henüz üye olmadın mı?", style: TextStyle(color: Color(0xff000000),fontSize: 11)),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff08B2E3),
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(20)
                          ),
                          padding: EdgeInsets.fromLTRB(35, 12, 35, 12)
                      ),
                      child: const Text("KAYIT OL", style: TextStyle(color: Color(0xff484D6D), fontSize: 15, fontWeight: FontWeight.w900),)
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );

  }

  doLogin(String username, String password) async{
    var res = await userLogin(username.trim(), password.trim());
    if (res['status'] == 'SUCCESS'){
      print(res['message']);
      String id = res['id'];
      String name = res['name'];
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BnbPage(userid: id, name: name, selectedIndex: 0,)));
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