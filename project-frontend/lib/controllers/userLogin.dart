import 'dart:convert';
import 'package:http/http.dart' as http;

Future userLogin (String username, String password) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:8080/api/login"),
      headers: {"Accept":"Application/json"},
      body: {'username':username, 'password':password}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}