import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({required this.getUrl});
  final String getUrl;

  Future<void> getData() async {
    var url1 = Uri.parse(getUrl);
    http.Response response = await http.get(url1);

    if (response.statusCode == 200) {
      String data = response.body;
      var dataToSend = jsonDecode(data);
      print(dataToSend['rate']);
      return dataToSend;
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }
}
