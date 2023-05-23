import 'dart:convert';
import 'package:http/http.dart' as http;

Future addWork (String userid, String title, String status, String short, String lastDate, String money) async {

  final response = await http.post(Uri.parse("http://10.0.2.2:3000/work/add-work"),
      headers: {"Accept":"Application/json"},
      body: {'userid':userid, 'title':title, 'status':status, 'short':short, 'lastDate':lastDate, 'money':money}
  );

  var decodedData = jsonDecode(response.body);
  return decodedData;

}