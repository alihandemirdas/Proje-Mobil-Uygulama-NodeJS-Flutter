import 'dart:convert';
import 'package:http/http.dart' as http;

Future addMoney (String userid, String title, String type, String money) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:8080/money/add-money"),
      headers: {"Accept":"Application/json"},
      body: {'userid':userid,'title':title,'type':type,'money':money}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}