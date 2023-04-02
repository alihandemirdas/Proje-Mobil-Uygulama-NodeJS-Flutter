import 'dart:convert';
import 'package:http/http.dart' as http;

Future userForgotPassword(String email) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/api/forget-password"),
      headers: {"Accept":"Application/json"},
      body: {'email':email}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}