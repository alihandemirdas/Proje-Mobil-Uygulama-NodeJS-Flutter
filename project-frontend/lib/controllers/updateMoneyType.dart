import 'dart:convert';
import 'package:http/http.dart' as http;

Future updateMoneyTypeWorkId(String workid, String type) async {
  print("geldi mi acaba");
  final response = await http.post(Uri.parse("http://10.0.2.2:3000/money/update-money-type-workid"),
      headers: {"Accept":"Application/json"},
      body: {"workid":workid, "type":type}
  );
  print("geldi mi acaba 2");

  var decodedData = jsonDecode(response.body);
  return decodedData;

}