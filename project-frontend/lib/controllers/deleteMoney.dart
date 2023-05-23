import 'dart:convert';
import 'package:http/http.dart' as http;

Future deleteMoney(String id) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/money/delete-money"),
      headers: {"Accept":"Application/json"},
      body: {"id":id}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}