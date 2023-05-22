import 'dart:convert';
import 'package:http/http.dart' as http;

Future userResetPassword(String token, String password) async {

  final response = await http.get(Uri.parse("http://10.0.2.2:8080/api/reset-password?token=${token}&password=${password}"),
      headers: {"Accept":"Application/json"},
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}