import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proje/controllers/userForgotPassword.dart';
import 'package:proje/screens/resetPasswordCode.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordPageState();
  }
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final TextEditingController emailController = TextEditingController();


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
              SizedBox(
                height: 40,
              ),
              const Text("E-posta adresinizi girin, size bir şifre sıfırlama bağlantısı göndereceğiz.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(
                height: 20,
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
                height: 20,
              ),
              ElevatedButton(
                  onPressed: (){
                    if(emailController.text.isNotEmpty){
                      doForgetPassword(emailController.text);
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
                  child: const Text("GÖNDER", style: TextStyle(color: Color(0xff484D6D), fontSize: 15, fontWeight: FontWeight.w900),)
              ),
            ],
          ),
        ),
      ),
    );
  }

  doForgetPassword(String email) async{
    var res = await userForgotPassword(email.trim());
    if (res['status'] == 'SUCCESS'){
      print(res['message']);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ResetPasswordCodePage()));
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
