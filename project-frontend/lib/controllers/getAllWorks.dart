import 'dart:convert';
import 'package:http/http.dart' as http;

Future getAllWorks(String userid) async {

  final response = await http.get(Uri.parse("http://10.0.2.2:3000/work/get-all-works?userid=${userid}"),
    headers: {"Accept":"Application/json"},
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}