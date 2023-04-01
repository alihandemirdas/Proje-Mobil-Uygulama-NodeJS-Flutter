import 'dart:convert';
import 'package:http/http.dart' as http;

Future userRegister (String name, String surname, String email, String username, String password) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/api/register"),
      headers: {"Accept":"Application/json"},
      body: {'name':name, 'surname':surname, 'email':email, 'username':username, 'password':password}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}