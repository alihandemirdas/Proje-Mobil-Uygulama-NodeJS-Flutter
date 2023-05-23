import 'dart:convert';
import 'package:http/http.dart' as http;

Future deleteMoneyByWorkId(String workid) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/money/delete-money-workid"),
      headers: {"Accept":"Application/json"},
      body: {"workid":workid}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}